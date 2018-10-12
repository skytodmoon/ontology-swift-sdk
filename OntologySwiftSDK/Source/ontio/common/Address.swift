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
    public let checksummedHex: HexString
    
    public init(hexString: HexString) throws {
//        try Address.validateAddress(hexString: hexString)
//        self.checksummedHex = Address.checksum(address: hexString)
        self.checksummedHex = hexString
    }
}

public extension Address {
    
    init(compressedHash: Data) throws {
        try self.init(hexString: compressedHash.toHexString())
    }
    
    init(uncompressedHash: Data) throws {
        try self.init(hexString: uncompressedHash.toHexString())
    }
    
    init(data: Data) throws {
        try self.init(hexString: Base58.encode(data))
    }
    
    init?(uncheckedString: String) {
        do {
            try self.init(hexString: uncheckedString)
        } catch {
            return nil
        }
    }
    
    init(publicKey: PublicKey, network: Network) {
        let system = Ont(network)
        //let compressedHash = system.compressedHash(from: publicKey)
        let hash = system.compressedHash(from: publicKey)
        do {
            try self.init(data: hash)
        } catch {
            fatalError("Incorrect implementation, using `publicKey:network` initializer should never result in error: `\(error)`")
        }
    }
    
    init(keyPair: KeyPair, network: Network) {
        self.init(publicKey: keyPair.publicKey, network: network)
    }
}
public extension Address {
    
    public enum Error: Swift.Error {
        case tooLong
        case tooShort
        case containsInvalidCharacters
    }
    
//    static func checksum(address hex: HexString) -> String {
//        let hash = EllipticCurveKit.Crypto.hash(Data(hex: hex), function: HashFunction.sha256).asHex
//        let address = hex.lowercased().droppingLeading0x()
//        var checksummed = ""
//        for (i, character) in address.enumerated() {
//            let index = String.Index(encodedOffset: i)
//            let string = String(character)
//            let integer = Int(String(hash[index]), radix: 16)!
//            if integer >= 8 {
//                checksummed += string.uppercased()
//            } else {
//                checksummed += string
//            }
//        }
//        return checksummed
//    }
//
//    static func isAddressChecksummed(_ address: HexString) -> Bool {
//        guard
//            address.isAddress,
//            case let checksummed = checksum(address: address),
//            checksummed == address || checksummed == address.droppingLeading0x()
//            else { return false }
//        return true
//    }
//
//    static func isValidAddress(hexString: HexString) -> Bool {
//        do {
//            try validateAddress(hexString: hexString)
//            return true
//        } catch {
//            return false
//        }
//    }
//    static func validateAddress(hexString: HexString) throws {
//        let hex = hexString.droppingLeading0x()
//        if hex.count < lengthOfValidAddresses {
//            throw Error.tooShort
//        }
//        if hex.count > lengthOfValidAddresses {
//            throw Error.tooLong
//        }
//        if Number(hexString: hex) == nil {
//            throw Error.containsInvalidCharacters
//        }
//        // is valid
//    }
    
    static func base58checkWithData(data: Data) -> Data{
        let addressData = data + Crypto.sha2Sha256(data).subdata(in: 0...3)
        let baseDataStr = Base58.encode(addressData)
        let baseData =  Base58.decode(baseDataStr)
        return baseData
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

