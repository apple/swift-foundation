//===----------------------------------------------------------------------===//
 //
 // This source file is part of the Swift Collections open source project
 //
 // Copyright (c) 2022 Apple Inc. and the Swift project authors
 // Licensed under Apache License v2.0 with Runtime Library Exception
 //
 // See https://swift.org/LICENSE.txt for license information
 //
 //===----------------------------------------------------------------------===//

@available(macOS 10.10, iOS 8.0, watchOS 2.0, tvOS 9.0, *)
extension CocoaError.Code {
    public static var fileNoSuchFile: CocoaError.Code {
        CocoaError.Code(rawValue: 4)
    }
    public static var fileLocking: CocoaError.Code {
        CocoaError.Code(rawValue: 255)
    }
    public static var fileReadUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 256)
    }
    public static var fileReadNoPermission: CocoaError.Code {
        CocoaError.Code(rawValue: 257)
    }
    public static var fileReadInvalidFileName: CocoaError.Code {
        CocoaError.Code(rawValue: 258)
    }
    public static var fileReadCorruptFile: CocoaError.Code {
        CocoaError.Code(rawValue: 259)
    }
    public static var fileReadNoSuchFile: CocoaError.Code {
        CocoaError.Code(rawValue: 260)
    }
    public static var fileReadInapplicableStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 261)
    }
    public static var fileReadUnsupportedScheme: CocoaError.Code {
        CocoaError.Code(rawValue: 262)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileReadTooLarge: CocoaError.Code {
        CocoaError.Code(rawValue: 263)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileReadUnknownStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 264)
    }

    public static var fileWriteUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 512)
    }
    public static var fileWriteNoPermission: CocoaError.Code {
        CocoaError.Code(rawValue: 513)
    }
    public static var fileWriteInvalidFileName: CocoaError.Code {
        CocoaError.Code(rawValue: 514)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileWriteFileExists: CocoaError.Code {
        CocoaError.Code(rawValue: 516)
    }

    public static var fileWriteInapplicableStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 517)
    }
    public static var fileWriteUnsupportedScheme: CocoaError.Code {
        CocoaError.Code(rawValue: 518)
    }
    public static var fileWriteOutOfSpace: CocoaError.Code {
        CocoaError.Code(rawValue: 640)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileWriteVolumeReadOnly: CocoaError.Code {
        CocoaError.Code(rawValue: 642)
    }

    @available(macOS, introduced: 10.11) @available(iOS, unavailable)
    public static var fileManagerUnmountUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 768)
    }

    @available(macOS, introduced: 10.11) @available(iOS, unavailable)
    public static var fileManagerUnmountBusy: CocoaError.Code {
        CocoaError.Code(rawValue: 769)
    }

    public static var keyValueValidation: CocoaError.Code {
        CocoaError.Code(rawValue: 1024)
    }
    public static var formatting: CocoaError.Code {
        CocoaError.Code(rawValue: 2048)
    }
    public static var userCancelled: CocoaError.Code {
        CocoaError.Code(rawValue: 3072)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var featureUnsupported: CocoaError.Code {
        CocoaError.Code(rawValue: 3328)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableNotLoadable: CocoaError.Code {
        CocoaError.Code(rawValue: 3584)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableArchitectureMismatch: CocoaError.Code {
        CocoaError.Code(rawValue: 3585)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableRuntimeMismatch: CocoaError.Code {
        CocoaError.Code(rawValue: 3586)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableLoad: CocoaError.Code {
        CocoaError.Code(rawValue: 3587)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableLink: CocoaError.Code {
        CocoaError.Code(rawValue: 3588)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadCorrupt: CocoaError.Code {
        CocoaError.Code(rawValue: 3840)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadUnknownVersion: CocoaError.Code {
        CocoaError.Code(rawValue: 3841)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadStream: CocoaError.Code {
        CocoaError.Code(rawValue: 3842)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListWriteStream: CocoaError.Code {
        CocoaError.Code(rawValue: 3851)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListWriteInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 3852)
    }

#if FOUNDATION_FRAMEWORK
    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionInterrupted: CocoaError.Code {
        CocoaError.Code(rawValue: 4097)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 4099)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionReplyInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 4101)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileUnavailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4353)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileNotUploadedDueToQuota: CocoaError.Code {
        CocoaError.Code(rawValue: 4354)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileUbiquityServerNotAvailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4355)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityHandoffFailed: CocoaError.Code {
        CocoaError.Code(rawValue: 4608)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityConnectionUnavailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4609)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityRemoteApplicationTimedOut: CocoaError.Code {
        CocoaError.Code(rawValue: 4610)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityHandoffUserInfoTooLarge: CocoaError.Code {
        CocoaError.Code(rawValue: 4611)
    }

    @available(macOS, introduced: 10.11) @available(iOS, introduced: 9.0)
    public static var coderReadCorrupt: CocoaError.Code {
        CocoaError.Code(rawValue: 4864)
    }

    @available(macOS, introduced: 10.11) @available(iOS, introduced: 9.0)
    public static var coderValueNotFound: CocoaError.Code {
        CocoaError.Code(rawValue: 4865)
    }

    public static var coderInvalidValue: CocoaError.Code {
        CocoaError.Code(rawValue: 4866)
    }
#endif
}

@available(macOS 10.10, iOS 8.0, watchOS 2.0, tvOS 9.0, *)
extension CocoaError {
    public static var fileNoSuchFile: CocoaError.Code {
        CocoaError.Code(rawValue: 4)
    }
    public static var fileLocking: CocoaError.Code {
        CocoaError.Code(rawValue: 255)
    }
    public static var fileReadUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 256)
    }
    public static var fileReadNoPermission: CocoaError.Code {
        CocoaError.Code(rawValue: 257)
    }
    public static var fileReadInvalidFileName: CocoaError.Code {
        CocoaError.Code(rawValue: 258)
    }
    public static var fileReadCorruptFile: CocoaError.Code {
        CocoaError.Code(rawValue: 259)
    }
    public static var fileReadNoSuchFile: CocoaError.Code {
        CocoaError.Code(rawValue: 260)
    }
    public static var fileReadInapplicableStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 261)
    }
    public static var fileReadUnsupportedScheme: CocoaError.Code {
        CocoaError.Code(rawValue: 262)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileReadTooLarge: CocoaError.Code {
        CocoaError.Code(rawValue: 263)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileReadUnknownStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 264)
    }

    public static var fileWriteUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 512)
    }
    public static var fileWriteNoPermission: CocoaError.Code {
        CocoaError.Code(rawValue: 513)
    }
    public static var fileWriteInvalidFileName: CocoaError.Code {
        CocoaError.Code(rawValue: 514)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileWriteFileExists: CocoaError.Code {
        CocoaError.Code(rawValue: 516)
    }

    public static var fileWriteInapplicableStringEncoding: CocoaError.Code {
        CocoaError.Code(rawValue: 517)
    }
    public static var fileWriteUnsupportedScheme: CocoaError.Code {
        CocoaError.Code(rawValue: 518)
    }
    public static var fileWriteOutOfSpace: CocoaError.Code {
        CocoaError.Code(rawValue: 640)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var fileWriteVolumeReadOnly: CocoaError.Code {
        CocoaError.Code(rawValue: 642)
    }

    @available(macOS, introduced: 10.11) @available(iOS, unavailable)
    public static var fileManagerUnmountUnknown: CocoaError.Code {
        CocoaError.Code(rawValue: 768)
    }

    @available(macOS, introduced: 10.11) @available(iOS, unavailable)
    public static var fileManagerUnmountBusy: CocoaError.Code {
        CocoaError.Code(rawValue: 769)
    }

    public static var keyValueValidation: CocoaError.Code {
        CocoaError.Code(rawValue: 1024)
    }
    public static var formatting: CocoaError.Code {
        CocoaError.Code(rawValue: 2048)
    }
    public static var userCancelled: CocoaError.Code {
        CocoaError.Code(rawValue: 3072)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var featureUnsupported: CocoaError.Code {
        CocoaError.Code(rawValue: 3328)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableNotLoadable: CocoaError.Code {
        CocoaError.Code(rawValue: 3584)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableArchitectureMismatch: CocoaError.Code {
        CocoaError.Code(rawValue: 3585)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableRuntimeMismatch: CocoaError.Code {
        CocoaError.Code(rawValue: 3586)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableLoad: CocoaError.Code {
        CocoaError.Code(rawValue: 3587)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var executableLink: CocoaError.Code {
        CocoaError.Code(rawValue: 3588)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadCorrupt: CocoaError.Code {
        CocoaError.Code(rawValue: 3840)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadUnknownVersion: CocoaError.Code {
        CocoaError.Code(rawValue: 3841)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListReadStream: CocoaError.Code {
        CocoaError.Code(rawValue: 3842)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListWriteStream: CocoaError.Code {
        CocoaError.Code(rawValue: 3851)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var propertyListWriteInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 3852)
    }

#if FOUNDATION_FRAMEWORK
    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionInterrupted: CocoaError.Code {
        CocoaError.Code(rawValue: 4097)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 4099)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var xpcConnectionReplyInvalid: CocoaError.Code {
        CocoaError.Code(rawValue: 4101)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileUnavailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4353)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileNotUploadedDueToQuota: CocoaError.Code {
        CocoaError.Code(rawValue: 4354)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var ubiquitousFileUbiquityServerNotAvailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4355)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityHandoffFailed: CocoaError.Code {
        CocoaError.Code(rawValue: 4608)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityConnectionUnavailable: CocoaError.Code {
        CocoaError.Code(rawValue: 4609)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityRemoteApplicationTimedOut: CocoaError.Code {
        CocoaError.Code(rawValue: 4610)
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public static var userActivityHandoffUserInfoTooLarge: CocoaError.Code {
        CocoaError.Code(rawValue: 4611)
    }

    @available(macOS, introduced: 10.11) @available(iOS, introduced: 9.0)
    public static var coderReadCorrupt: CocoaError.Code {
        CocoaError.Code(rawValue: 4864)
    }

    @available(macOS, introduced: 10.11) @available(iOS, introduced: 9.0)
    public static var coderValueNotFound: CocoaError.Code {
        CocoaError.Code(rawValue: 4865)
    }

    public static var coderInvalidValue: CocoaError.Code {
        CocoaError.Code(rawValue: 4866)
    }
#endif
}

@available(macOS 10.10, iOS 8.0, watchOS 2.0, tvOS 9.0, *)
extension CocoaError {
    @available(macOS, introduced: 10.11) @available(iOS, introduced: 9.0)
    public var isCoderError: Bool {
        code.rawValue >= 4864 && code.rawValue <= 4991
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public var isExecutableError: Bool {
        code.rawValue >= 3584 && code.rawValue <= 3839
    }

    public var isFileError: Bool {
        code.rawValue >= 0 && code.rawValue <= 1023
    }

    public var isFormattingError: Bool {
        code.rawValue >= 2048 && code.rawValue <= 2559
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public var isPropertyListError: Bool {
        code.rawValue >= 3840 && code.rawValue <= 4095
    }

    public var isValidationError: Bool {
        code.rawValue >= 1024 && code.rawValue <= 2047
    }
    
#if FOUNDATION_FRAMEWORK
    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public var isUbiquitousFileError: Bool {
        code.rawValue >= 4352 && code.rawValue <= 4607
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public var isUserActivityError: Bool {
        code.rawValue >= 4608 && code.rawValue <= 4863
    }

    @available(macOS, introduced: 10.10) @available(iOS, introduced: 8.0)
    public var isXPCConnectionError: Bool {
        code.rawValue >= 4096 && code.rawValue <= 4224
    }
#endif
}
