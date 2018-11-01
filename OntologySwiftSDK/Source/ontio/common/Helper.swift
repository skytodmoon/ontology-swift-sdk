//
//  Helper.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/26.
//  Copyright © 2018年 com.wm. All rights reserved.
//

import Foundation
public class Helper{
//    static public func hexToBytes(hexStr: String) throws -> [UInt8] {
//        if hexStr.count == 0 {
//            return [UInt8]()
//        }
//        if hexStr.count % 2 == 1 {
//            throw Exception.IllegalArgumentException
//        }
//        
//        var result: [UInt8] = [UInt8](repeating:0, count:hexStr.count/2)
//        for i in 0...hexStr.count {
//            let range: Range = Range.init(NSRange(location: i * 2, length: i * 2 + 2))!
//            let tempStr = hexStr[range]
//            result[i] = UInt8(hexStringToInt(from: tempStr))
//        }
//        return result
//        
//    }
//    
//    func hexStringToInt(from:String) -> Int {
//        let str = from.uppercased()
//        var sum = 0
//        for i in str.utf8 {
//            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
//            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
//                sum -= 7
//            }
//        }
//        return sum
//    }
}

// 下标截取任意位置的便捷方法
extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}
//不包含后几个字符串的方法
extension String {
    func dropLast(_ n: Int = 1) -> String {
        return String(dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
}

