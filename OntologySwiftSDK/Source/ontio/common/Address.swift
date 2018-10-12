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
    public static let lengthOfValidAddresses: Int = 100
    
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
        try self.init(hexString: uncheckedString,publicKeyHash160: Hash160Data)
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
    
    static func base58checkToData(addressStr: String) -> Data {
        
//        NSData *d = self.base58ToData;
//
//        if (d.length < 4) return nil;
//
//        NSData *data = CFBridgingRelease(CFDataCreate(SecureAllocator(), d.bytes, d.length - 4));
//
//        // verify checksum
//        NSData *datachecksum1 = [[data SHA256_2] subdataWithRange:NSMakeRange(0, 4)];
//        NSData *datachecksum2 = [d subdataWithRange:NSMakeRange(d.length - 4, 4)];
//        if (![datachecksum1 isEqual:datachecksum2]) return nil;
//        return data;
    }
    
    static func hash160ToData(uncheckStr: String) -> Data {
        //let data = base58checkWithData(data: <#T##Data#>)
        //let data = base
        //        unsigned char COIN_VERSION = 0x17;
        //        unsigned char data_coin_version;
        //
        //        [data getBytes:&data_coin_version length:1];
        //        if (data_coin_version != COIN_VERSION) {
        //            return nil;
        //        }
        //
        //        return [data subdataWithRange:NSMakeRange(1, 20)];
        
        
    }
    
    static func hash160ToAddress(data: Data) ->String {
        let COIN_VERSION:[Byte] = [0x17]
        let program = Data(bytes: COIN_VERSION, count: 1)
        let hexData = program + data
        return base58checkWithData(data:hexData)
    }
    

}
extension Data
{
    public func subdata(in range: CountableClosedRange<Data.Index>) -> Data
    {
        return self.subdata(in: range.lowerBound..<range.upperBound + 1)
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

