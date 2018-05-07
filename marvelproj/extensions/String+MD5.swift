//
//  Swift+MD5.swift
//  marvelproj
//
//  Created by Andre Nogueira on 07/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
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
