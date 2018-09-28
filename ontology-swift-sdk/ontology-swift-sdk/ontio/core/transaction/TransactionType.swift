//
//  TransactionType.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//

enum TransactionType: UInt8 {
    case Bookkeeping         = 0x00
    case Bookkeeper          = 0x02
    case Claim               = 0x03
    case Enrollment          = 0x04
    case Vote                = 0x05
    case DeployCode          = 0xd0
    case InvokeCode          = 0xd1
    case TransferTransaction = 0x80
    
    var value: UInt8 {
        return rawValue
    }
    
    static func valueOf(v: UInt8) throws -> TransactionType{
        guard let tempType = TransactionType(rawValue: v)
        else { throw Exception.IllegalArgumentException }
        return tempType
    }

}


