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

extension _Rope {
  mutating func prepend(_ item: __owned Element) {
    invalidateIndices()
    insert(item, at: startIndex)
  }
  
  mutating func insert(
    _ item: __owned Element,
    at index: Index
  ) {
    validate(index)
    insert(item, at: index._path)
  }

  mutating func insert(
    _ item: __owned Element,
    at path: Path
  ) {
    if path == endPath {
      append(item)
      return
    }
    if let spawn = root.insert(Item(item), at: path) {
      _root = .createInner(children: root, spawn)
    }
    invalidateIndices()
  }
  
  mutating func insert(
    _ item: __owned Element,
    at position: Int,
    in metric: some _RopeMetric<Element>
  ) {
    if position == metric.size(of: summary) {
      append(item)
      return
    }
    if let spawn = root.insert(Item(item), at: position, in: metric) {
      _root = .createInner(children: root, spawn)
    }
    invalidateIndices()
  }
}

extension _Rope.Node {
  mutating func prepend(_ item: __owned Item) -> Self? {
    insert(item, at: startPath)
  }
  
  mutating func insert(
    _ item: __owned Item,
    at path: Path
  ) -> Self? {
    ensureUnique()
    let h = height
    let slot = path[h]
    if h > 0 {
      precondition(slot < childCount, "Index out of bounds")
      return _innerInsert(at: slot) { $0.insert(item, at: path) }
    }
    precondition(slot <= childCount, "Index out of bounds")
    return _leafInsert(item, at: slot)
  }
  
  mutating func insert(
    _ item: __owned Item,
    at position: Int,
    in metric: some _RopeMetric<Element>
  ) -> Self? {
    ensureUnique()
    if height > 0 {
      let (slot, remaining) = readInner {
        $0.findSlot(at: position, in: metric, preferEnd: false)
      }
      return _innerInsert(at: slot) { $0.insert(item, at: remaining, in: metric) }
    }
    let (slot, remaining) = readLeaf {
      $0.findSlot(at: position, in: metric, preferEnd: false)
    }
    precondition(remaining == 0, "Inserted element doesn't fall on an element boundary")
    return _leafInsert(item, at: slot)
  }
}

extension _Rope.Node {
  mutating func _innerInsert(
    at slot: Int,
    with body: (inout Self) -> Self?
  ) -> Self? {
    assert(slot < childCount)
    var summary = self.summary
    let spawn = updateInner {
      let p = $0.mutableChildPtr(at: slot)
      summary.subtract(p.pointee.summary)
      let spawn = body(&p.pointee)
      summary.add(p.pointee.summary)
      return spawn
    }
    self.summary = summary
    guard let spawn = spawn else { return nil }
    return _applySpawn(spawn, of: slot)
  }
  
  mutating func _applySpawn(_ spawn: __owned Self, of slot: Int) -> Self? {
    var spawn = spawn
    var nextSlot = slot + 1
#if true // Compress existing nodes if possible.
    if slot > 0 {
      // Try merging remainder into previous child.
      updateInner {
        let c = $0.mutableChildren
        let s = c[slot - 1].childCount + c[slot].childCount
        guard s <= Summary.maxNodeSize else { return }
        Self.redistributeChildren(&c[slot - 1], &c[slot], to: s)
        let removed = $0._removeChild(at: slot)
        assert(removed.childCount == 0)
        nextSlot -= 1
      }
    }
    if nextSlot < childCount {
      // Try merging new spawn into subsequent child.
      let merged: Summary? = updateInner {
        let c = $0.mutableChildren
        let s = spawn.childCount + c[nextSlot].childCount
        guard s <= Summary.maxNodeSize else { return nil }
        let summary = spawn.summary
        Self.redistributeChildren(&spawn, &c[nextSlot], to: 0)
        assert(spawn.childCount == 0)
        return summary
      }
      if let merged = merged {
        self.summary.add(merged)
        return nil
      }
    }
#endif
    guard isFull else {
      _insertNode(spawn, at: nextSlot)
      return nil
    }
    var spawn2 = split(keeping: childCount / 2)
    if nextSlot < childCount {
      _insertNode(spawn, at: nextSlot)
    } else {
      spawn2._insertNode(spawn, at: nextSlot - childCount)
    }
    return spawn2
  }
}

extension _Rope.Node {
  mutating func _leafInsert(_ item: __owned Item, at slot: Int) -> Self? {
    assert(slot <= childCount)
    var item = item
    if item.isUndersized, childCount > 0, _rebalanceBeforeInsert(&item, at: slot) {
      return nil
    }
    
    guard isFull else {
      _insertItem(item, at: slot)
      return nil
    }
    var spawn = split(keeping: childCount / 2)
    if slot <= childCount {
      _insertItem(item, at: slot)
    } else {
      spawn._insertItem(item, at: slot - childCount)
    }
    return spawn
  }
  
  mutating func _rebalanceBeforeInsert(_ item: inout Item, at slot: Int) -> Bool {
    assert(item.isUndersized)
    let r = updateLeaf { (h) -> (merged: Bool, delta: Summary) in
      if slot > 0 {
        let p = h.mutableChildPtr(at: slot - 1)
        let sum = p.pointee.summary
        let merged = p.pointee.rebalance(nextNeighbor: &item)
        let delta = p.pointee.summary.subtracting(sum)
        return (merged, delta)
      }
      let p = h.mutableChildPtr(at: slot)
      let sum = p.pointee.summary
      let merged = p.pointee.rebalance(prevNeighbor: &item)
      let delta = p.pointee.summary.subtracting(sum)
      return (merged, delta)
    }
    self.summary.add(r.delta)
    return r.merged
  }
}
