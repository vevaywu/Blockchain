//
//  ViewController.swift
//  Blockchain
//
//  Created by Boni on 2022/8/9.
//

import UIKit


class ViewController: UIViewController {
    var blockchain: Blockchain = Blockchain()

    lazy var newBlockBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 40))
        button.setTitle("挖矿", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newBlockBtn)
        
        blockchain.fullChain()
    }

    @objc func buttonAction(_ sender: UIButton) {
        blockchain.mine()
    }

}
