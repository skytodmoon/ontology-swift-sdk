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
import Foundation
import CryptoSwift
import EllipticCurveKit




public struct Address {
    public static let lengthOfValidAddresses: Int = 34
    
    /// The compressed hashed data as a hexadecimal string
    /// which checksum has been confirmed to be correct.
    public let addressStr: HexString
    public let publicKeyHash160: Data


    
    public init(hexString: HexString, publicKeyHash160:Data) throws {
//        self.checksummedHex = Address.checksum(address: hexString)

        //
        self.addressStr = hexString
        self.publicKeyHash160 = publicKeyHash160
    }

    
}

public extension Address {
    
    init(data: Data) {
        do {
            try self.init(hexString: Base58.encode(data), publicKeyHash160: data)
        } catch  {
           fatalError("Incorrect implementation, using `publicKey:network` initializer should never result in error: `\(error)`")
        }
        
    }
    init?(uncheckedData: Data) throws {
        if uncheckedData.count != 20 {
            throw ErrorCode.InvalidData
        }
        let addressStr = Address.hash160ToAddress(data: uncheckedData)
        try self.init(hexString:addressStr ,publicKeyHash160:uncheckedData)
        //Base58.encode(data)
    }
    
//    init(compressedHash: Data) throws {
//        try self.init(hexString: compressedHash.toHexString())
//    }
//
//    init(uncompressedHash: Data) throws {
//        try self.init(hexString: uncompressedHash.toHexString())
//    }
    

    
    init?(uncheckedString: String) throws{
        if uncheckedString.count !=  Address.lengthOfValidAddresses{
            throw ErrorCode.InvalidData
        }
        let Hash160Data = Address.hash160ToData(uncheckStr: uncheckedString)
        try self.init(hexString: uncheckedString,publicKeyHash160: Hash160Data!)
    }
    
    init(publicKey: PublicKey, network: Network) {
        let system = Ont(network)
        //let compressedHash = system.compressedHash(from: publicKey)
        let publicKeyData = system.compressedHash(from: publicKey)
//        do {
            self.init(data: publicKeyData)
//        } catch {
//            fatalError("Incorrect implementation, using `publicKey:network` initializer should never result in error: `\(error)`")
//        }
    }
    
    init(keyPair: KeyPair, network: Network) {
        self.init(publicKey: keyPair.publicKey, network: network)
    }
}
public extension Address {
    
    static func base58checkWithData(data: Data) -> String {
        let addressData = data + Crypto.sha2Sha256(data).subdata(in: 0...3)
        let baseDataStr = Base58.encode(addressData)
        return baseDataStr
    }
    
    static func base58checkToData(addressStr: String) -> Data? {
        let data:Data = Base58.decode(addressStr)
        guard data.count > 4 else {
            return nil
        }
        let checkData = CFDataCreate(secureAllocator, data.bytes, data.count-4)! as Data
        let datachecksum1 = Crypto.sha2Sha256_twice(checkData).subdata(in: 0...3)
        let datachecksum2 = checkData .subdata(in: (data.count - 4) ... (data.count - 1))
        guard datachecksum1 == datachecksum2 else{
            return nil
        }
        return data
    }
    
    static func hash160ToData(uncheckStr: String) -> Data?{
        let data = base58checkToData(addressStr: uncheckStr)
        guard data?.count == 160/8 + 1 else{
            return nil
        }
        return data?.subdata(in: 1...((data?.count)! - 2))
    }
    
    static func hash160ToAddress(data: Data) ->String {
        let COIN_VERSION:[Byte] = [0x17]
        let program = Data(bytes: COIN_VERSION, count: 1)
        let hexData = program + data
        return base58checkWithData(data:hexData)
    }
    
    static func WifToPrivateKey(wif:String) -> Data?{
        let privKeyData = base58checkToData(addressStr: wif)
        guard privKeyData != nil && privKeyData?.count == 34 else {
            return nil
        }
        
        let version = privKeyData?.subdata(in: 0...1).bytes.first
        let compressed = privKeyData?.subdata(in: 32...33).bytes.first
        if version != 0x80 || compressed != 0x01 {
            return nil
        }
        return privKeyData?.subdata(in: 1...33)
        
    }
    

}


extension HexString {
//    func droppingLeading0x() -> HexString {
//        var string = self
//        while string.starts(with: "0x") {
//            string = String(string.dropFirst(2))
//        }
//        return string
//    }
//    
//    var isAddress: Bool {
//        return Address.isValidAddress(hexString: self)
//    }
}

