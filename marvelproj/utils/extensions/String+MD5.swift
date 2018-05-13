//
//  Swift+MD5.swift
//  marvelproj
//
// SwiftMD5 is released under the BSD license.
// https://github.com/mpurland/SwiftMD5/blob/master/SwiftMD5/SwiftMD5.swift
//

import Foundation

// MARK: - String extension
extension String {
    public var md5: String {
        return SwiftMD5().encodeMD5(digest: md5Digest)
    }
    
    public var md5Digest: [UInt8] {
        let bytes = [UInt8](self.utf8)
        let digest = SwiftMD5().md5(bytes)
        return digest.digest
    }
}
