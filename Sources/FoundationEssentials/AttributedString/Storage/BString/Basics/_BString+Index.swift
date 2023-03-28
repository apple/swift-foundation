//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Collections open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#if swift(>=5.8)

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString {
  internal struct Index: Sendable {
    typealias Rope = _BString.Rope

    // ┌─────────────────────┬──────────────┬────────────────────┐
    // │ b63:b9              │ b8           │ b7:b0              │
    // ├─────────────────────┼──────────────┼────────────────────┤
    // │ UTF-8 global offset │ UTF-16 delta │ UTF-8 chunk offset │
    // └─────────────────────┴──────────────┴────────────────────┘
    var _rawBits: UInt64

    /// A (possibly invalid) rope index.
    var _rope: Rope.Index?

    internal init(_raw: UInt64, rope: Rope.Index?) {
      self._rawBits = _raw
      self._rope = rope
    }
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index {
  internal var _utf8Offset: Int {
    Int(truncatingIfNeeded: _rawBits &>> 9)
  }

  internal var _isUTF16TrailingSurrogate: Bool {
    _orderingValue & 1 != 0
  }

  /// The base offset of the addressed chunk. Only valid if `_rope` is not nil.
  internal var _utf8BaseOffset: Int {
    _utf8Offset - _utf8ChunkOffset
  }

  /// The offset within the addressed chunk. Only valid if `_rope` is not nil.
  internal var _utf8ChunkOffset: Int {
    assert(_rope != nil)
    return Int(truncatingIfNeeded: _rawBits & 0xFF)
  }

  internal var _chunkIndex: String.Index {
    assert(_rope != nil)
    return String.Index(
        _utf8Offset: _utf8ChunkOffset, utf16TrailingSurrogate: _isUTF16TrailingSurrogate)
  }

  @inline(__always)
  internal var _orderingValue: UInt64 {
    _rawBits &>> 8
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index {
  @inline(__always)
  internal static func _bitsForUTF8Offset(_ utf8Offset: Int) -> UInt64 {
    let v = UInt64(truncatingIfNeeded: UInt(bitPattern: utf8Offset))
    assert(v &>> 55 == 0)
    return v &<< 9
  }

  @inline(__always)
  internal static var _utf16TrailingSurrogateBits: UInt64 { 0x100 }

  internal mutating func _clearUTF16TrailingSurrogate() {
    _rawBits &= ~Self._utf16TrailingSurrogateBits
  }

  internal init(_utf8Offset: Int) {
    _rawBits = Self._bitsForUTF8Offset(_utf8Offset)
    _rope = nil
  }

  internal init(_utf8Offset: Int, utf16TrailingSurrogate: Bool) {
    _rawBits = Self._bitsForUTF8Offset(_utf8Offset)
    if utf16TrailingSurrogate {
      _rawBits |= Self._utf16TrailingSurrogateBits
    }
    _rope = nil
  }

  internal init(
    _utf8Offset: Int, utf16TrailingSurrogate: Bool = false, rope: Rope.Index, chunkOffset: Int
  ) {
    _rawBits = Self._bitsForUTF8Offset(_utf8Offset)
    if utf16TrailingSurrogate {
      _rawBits |= Self._utf16TrailingSurrogateBits
    }
    assert(chunkOffset >= 0 && chunkOffset <= 0xFF)
    _rawBits |= UInt64(truncatingIfNeeded: chunkOffset) & 0xFF
    self._rope = rope
  }

  internal init(baseUTF8Offset: Int, rope: Rope.Index, chunk: String.Index) {
    let chunkUTF8Offset = chunk._utf8Offset
    self.init(
      _utf8Offset: baseUTF8Offset + chunkUTF8Offset,
      utf16TrailingSurrogate: chunk._utf16Delta > 0,
      rope: rope,
      chunkOffset: chunkUTF8Offset)
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index: Equatable {
  static func ==(left: Self, right: Self) -> Bool {
    left._orderingValue == right._orderingValue
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index: Comparable {
  static func <(left: Self, right: Self) -> Bool {
    left._orderingValue < right._orderingValue
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(_orderingValue)
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString.Index: CustomStringConvertible {
  internal var description: String {
    let utf16Offset = _isUTF16TrailingSurrogate ? "+1" : ""
    return "\(_utf8Offset)[utf8]\(utf16Offset)"
  }
}

@available(macOS 13.3, iOS 16.4, watchOS 9.4, tvOS 16.4, *)
extension _BString {
  func resolve(_ i: Index, preferEnd: Bool) -> Index {
    if var ri = i._rope, rope.isValid(ri) {
      if preferEnd {
        guard i._utf8Offset > 0, i._utf8ChunkOffset == 0 else { return i }
        rope.formIndex(before: &ri)
        let length = rope[ri].utf8Count
        let ci = String.Index(_utf8Offset: length)
        return Index(baseUTF8Offset: i._utf8Offset - length, rope: ri, chunk: ci)
      }
      guard i._utf8Offset < utf8Count, i._utf8ChunkOffset == rope[ri].utf8Count else {
        return i
      }
      rope.formIndex(after: &ri)
      let ci = String.Index(_utf8Offset: 0)
      return Index(baseUTF8Offset: i._utf8Offset, rope: ri, chunk: ci)
    }

    let (ri, chunkOffset) = rope.find(
      at: i._utf8Offset, in: UTF8Metric(), preferEnd: preferEnd)
    let ci = String.Index(
        _utf8Offset: chunkOffset, utf16TrailingSurrogate: i._isUTF16TrailingSurrogate)
    return Index(baseUTF8Offset: i._utf8Offset - ci._utf8Offset, rope: ri, chunk: ci)
  }
}

#endif
