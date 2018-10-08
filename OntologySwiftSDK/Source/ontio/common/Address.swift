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
    var address: [UInt8]?
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
        //let v: [UInt8] = Array(tempValue.utf8)
        let v: [UInt8] = try Helper.hexToBytes(hexStr: tempValue)
        if v.count != 20 {
            throw Exception.IllegalArgumentException
        }
        address = v
        //address = try getAddress(count: 20, value:v)
    }

    func getAddress(count: Int, value:[UInt8]) throws -> [UInt8] {
        if value.count != count{
            
        }
        return [0000]
    }
}
