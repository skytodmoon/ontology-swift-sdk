//
//  Address.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//
/**
 * Custom type which inherits base class defines 20-bit data,
 * it mostly used to defined contract address
 */
public class Address {
   static let ZERO:Address? = nil
   static let COIN_VERSION: UInt8 = 0x17
    init(value: String) throws {
        if value.count == 0 {
            throw Exception.NullPointerException
        }
        var tempValue: String = value
        if value .starts(with: "0x") {
            tempValue = String(value.prefix(2))
        }
        if tempValue.count != 40 {
            throw Exception.IllegalArgumentException
        }
        let v: [UInt8] = Array(tempValue.utf8)
    }
    init(value: [UInt8]) {
        
    }
}
