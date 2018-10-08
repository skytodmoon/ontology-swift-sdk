//
//  Transaction.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//

public class Transaction {
    var version: Int8 = 0
    //var txType: TransactionType
    var nonce: UInt32 = arc4random()
    var gasPrice: CLong = 0
    var gasLimit: CLong = 0
    //var payer: Address
}
