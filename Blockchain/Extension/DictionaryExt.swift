//
//  DictionaryExt.swift
//  Blockchain
//
//  Created by Boni on 2022/8/9.
//

import Foundation

public protocol JsonStringProtocol {
    
}

extension JsonStringProtocol {
    public func toJsonString() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed) {
                if let rString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    return rString
                }
            }
        }
        
        return ""
    }
}

extension Dictionary: JsonStringProtocol {}
extension NSDictionary: JsonStringProtocol {}

extension Dictionary {
    public mutating func append(_ key: String, _ value: Any?) {
        if value == nil { return }
        if let k = key as? Key, let v = value as? Value {
            self[k] = v
        }
    }
}

