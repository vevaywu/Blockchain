//
//  Convertable.swift
//  Blockchain
//
//  Created by Boni on 2022/8/10.
//

import Foundation

protocol Converable: Codable { }

extension Converable {
    func dictionary() -> Dictionary<String, Any> {
        var dict: Dictionary<String, Any>? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        guard let result = dict else { return [:] }
        return result
    }
    
    var description: String {
        get {
            return self.dictionary().toJsonString()
        }
    }
}
