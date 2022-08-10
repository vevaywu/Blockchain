//
//  DataExt.swift
//  Blockchain
//
//  Created by Boni on 2022/8/9.
//

import CommonCrypto
import CryptoKit
import Foundation

func hexString(_ iterator: Array<UInt8>.Iterator) -> String {
    return iterator.map {
        String(format: "%02x", $0)
    }.joined().uppercased()
}

extension String {
    var sha256: String {
        let utf8 = cString(using: .utf8)

        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))

        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)

        return digest.reduce("") { $0 + String(format: "%02x", $1) }
    }
}

extension Data {
    var sha256: String {
        if #available(iOS 13.0, *) {
            return hexString(SHA256.hash(data: self).makeIterator())
        } else {
            var disest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            withUnsafeBytes { bytes in
                _ = CC_SHA256(bytes.baseAddress, CC_LONG(self.count), &disest)
            }
            return hexString(disest.makeIterator())
        }
    }
}
