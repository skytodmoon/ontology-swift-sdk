//
//  StaticTools.swift
//  OntologySwiftSDK
//
//  Created by 孙琦 on 2018/10/18.
//  Copyright © 2018年 孙琦. All rights reserved.
//

import Foundation
import CryptoSwift

public let secureAllocator: CFAllocator = {
      var context = CFAllocatorContext()
      context.version = 0;
      CFAllocatorGetContext(kCFAllocatorDefault, &context)
      context.allocate = secureAllocate
      context.reallocate = secureReallocate;
      context.deallocate = secureDeallocate;
      return CFAllocatorCreate(kCFAllocatorDefault, &context).takeRetainedValue()
  }()

    private func secureAllocate(allocSize:CFIndex,hint:CFOptionFlags,info:UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?{
        guard let ptr = malloc(MemoryLayout<CFIndex>.stride + allocSize) else { return nil }
        // keep track of the size of the allocation so it can be cleansed before deallocation
        ptr.storeBytes(of: allocSize, as: CFIndex.self)
        return ptr.advanced(by: MemoryLayout<CFIndex>.stride)
    }
    
    private func secureDeallocate(ptr: UnsafeMutableRawPointer?, info: UnsafeMutableRawPointer?)
    {
        guard let ptr = ptr else { return }
        let allocSize = ptr.load(fromByteOffset: -MemoryLayout<CFIndex>.stride, as: CFIndex.self)
        memset(ptr, 0, allocSize) // cleanse allocated memory
        free(ptr.advanced(by: -MemoryLayout<CFIndex>.stride))
    }
    
    private func secureReallocate(ptr: UnsafeMutableRawPointer?, newsize: CFIndex, hint: CFOptionFlags,
                                  info: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
    {
        // there's no way to tell ahead of time if the original memory will be deallocted even if the new size is smaller
        // than the old size, so just cleanse and deallocate every time
        guard let ptr = ptr else { return nil }
        let newptr = secureAllocate(allocSize: newsize, hint: hint, info: info)
        let allocSize = ptr.load(fromByteOffset: -MemoryLayout<CFIndex>.stride, as: CFIndex.self)
        if (newptr != nil) { memcpy(newptr, ptr, (allocSize < newsize) ? allocSize : newsize) }
        secureDeallocate(ptr: ptr, info: info)
        return newptr
    }


public extension Dictionary {
    
    func toJSONString() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            if let json = String(data: data, encoding: String.Encoding.utf8) {
                return json
            }
        }
        
        return nil
    }
}

public extension Data
{
    public func subdata(in range: CountableClosedRange<Data.Index>) -> Data
    {
        return self.subdata(in: range.lowerBound..<range.upperBound + 1)
    }
}

public extension Dictionary
{
    public func convertDictionaryToString() -> String {
        var result:String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
            
        } catch {
            result = ""
        }
        return result
    }
    

}

public extension String{
    func convertStringToDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}

public extension AES{

    

}
