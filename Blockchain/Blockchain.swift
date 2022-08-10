//
//  Blockchain.swift
//  Blockchain
//
//  Created by Boni on 2022/8/9.
//

import Foundation

let kNodeIdentifier: String = UUID().uuidString.replacingOccurrences(of: "-", with: "")

/// 交易模型
struct Transaction: Converable {
    var sender: String      //交易发起人
    var recipient: String   //交易接收人
    var amount: Double      //交易金额
}

/// 区块模型
struct Block: Converable {
    var index: Int                  //区块高度
    var timestamp: Double           //区块产生时间
    var transactions: [Transaction] //区块记录的交易信息
    var nonce: Double               //区块工作量 - 找到有效区块所循环的次数
    var previousHash: String        //前一个区块的哈希

    var hashValue: String {         //区块的哈希
        return self.description.sha256
    }
    
    init(_ preIndex: Int, transactions: [Transaction], preNonce: Double, preHash: String) {
        self.index = preIndex + 1
        self.timestamp = Date().timeIntervalSince1970
        self.transactions = transactions
        self.nonce = preNonce
        self.previousHash = preHash
    }
}

/// 全链信息模型
struct FullChain: Converable {
    var chain: [Block]
    var length: Int
}

/// 区块链
class Blockchain {
    var currentTransactions: [Transaction]  //当前交易记录
    var chain: [Block]                      //链路
    var nodes: NSMutableSet                 //节点
    
    var lastBlock: Block {
        return chain.last! //因为有创世块，链中至少会有一个区块
    }
    
    init() {
        self.currentTransactions = [Transaction]()
        self.chain = []
        self.nodes = NSMutableSet()
        newBlock(100, "1") //创世块
    }
    
    /// 产生一个新区块
    /// - Parameters:
    ///   - proof: 工作量
    ///   - previousHash: 前一区块的哈希
    /// - Returns: 返回新产生的区块
    @discardableResult
    func newBlock(_ proof: Double, _ previousHash: String) -> Block {
        let block = Block(self.chain.count, transactions: self.currentTransactions, preNonce: proof, preHash: previousHash)
        
        self.chain.append(block)
        self.currentTransactions.removeAll()
        return block
    }
    
    /// 工作量算法
    /// - Parameter block: 待计算工作量的区块
    /// - Returns: 返回工作量
    func proofOfWork(_ block: Block) -> Double {
        let lastNonce = block.nonce
        let lastHash = block.hashValue
        
        var nonce: Double = 0
        while validNonce(lastNonce, nonce, lastHash) == false {
            nonce += 1
        }
        return nonce
    }
    
    /// 工作量有效性验证
    /// - Parameters:
    ///   - lastNonce: 上一个区块工作量
    ///   - nonce: 当前工作量
    ///   - lastHash: 上一个区块哈希
    /// - Returns: 返回布尔型 true-有效 false-无效
    func validNonce(_ lastNonce: Double, _ nonce: Double, _ lastHash: String) -> Bool {
        let guess = "\(lastNonce)\(nonce)\(lastHash)"
        let guessHash = guess.sha256
        return guessHash.hasPrefix("0000")
    }
    
    /// 产生一条新的交易记录
    /// - Parameters:
    ///   - sender: 交易人
    ///   - recipient: 被交易人
    ///   - amount: 交易金额
    /// - Returns: 返回区块高度
    @discardableResult
    func newTransactions(_ sender: String, _ recipient: String, _ amount: Double) -> Int {
        let transaction = Transaction(sender: sender, recipient: recipient, amount: amount)
        self.currentTransactions.append(transaction)
        
        return self.lastBlock.index + 1
    }
    
    /// 注册一个节点
    /// - Parameter address: 节点地址
    func registerNode(_ address: String) {
        self.nodes.add(address)
    }
    
    /// 区块链验证
    /// - Parameter chain: 待验证链
    /// - Returns: 返回验证结果 true-有效 false-无效
    func validChain(_ chain: [Block]) -> Bool {
        guard var lastBlock = chain.first else { return false }
        var curIndex = 1
        
        while curIndex < chain.count {
            let block = chain[curIndex]
            print("lastBlock: \(lastBlock.description)")
            print("block: \(block.description)")
            print("\n-----------------------------\n")
            let lastBlockHash = lastBlock.hashValue
            if lastBlockHash != block.previousHash {
                return false
            }
            
            if validNonce(lastBlock.nonce, block.nonce, lastBlockHash) == false {
                return false
            }
            
            lastBlock = block
            curIndex += 1
        }
        return true
    }
    
    /// 共识
    /// - Returns: 返回是否共识成功 true-已共识 false-共识失败
    func consensus() -> Bool {
        let neighbours = self.nodes
        let newChain:[Block] = []
        let maxLength = self.chain.count
        
        for node in neighbours {
//            let response =
        }
        
        if newChain.isEmpty {
            self.chain = newChain
            return true
        }
        
        return false
    }
   
    /// 矿井
    func mine() {
        print("开始挖矿: \(Date())")
        let proof = self.proofOfWork(lastBlock)
        self.newTransactions("0", kNodeIdentifier, 100)

        let preHash = lastBlock.hashValue
        _ = self.newBlock(proof, preHash)
        print("挖矿成功: \(Date())")
        
        self.fullChain()
    }
    
    /// 全链信息查看
    @discardableResult
    func fullChain() -> Dictionary<String, Any> {
        let fullChain = FullChain(chain: self.chain, length: self.chain.count)
        print(fullChain.description)
        print("\n")
        return fullChain.dictionary()
    }
}
