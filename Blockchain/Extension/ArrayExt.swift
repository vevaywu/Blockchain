//
//  ArrayExt.swift
//  Blockchain
//
//  Created by Boni on 2022/8/10.
//

import Foundation

extension Array {
    var description: String {
        var chains: String = "["
        for (index, block) in self.enumerated() {
            if let str = block as? Converable {
                let dict = str.dictionary()
                chains.append(dict.toJsonString())
            }
            
            if index < self.count - 1 {
                chains.append(",")
            }
        }
        chains.append("]")
        return chains
    }
}
