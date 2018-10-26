//
//  Account.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//
import EllipticCurveKit
import CryptoSwift
import scrypt

public typealias Curve = Secp256r1
public typealias KeyPair = EllipticCurveKit.KeyPair<Curve>
public typealias PrivateKey = EllipticCurveKit.PrivateKey<Curve>
public typealias PublicKey = EllipticCurveKit.PublicKey<Curve>
public typealias Signature = EllipticCurveKit.Signature<Curve>
public typealias Signer = EllipticCurveKit.AnyKeySigner<Schnorr<Curve>>
public typealias Network = EllipticCurveKit.Zilliqa.Network

public extension Network {
    static var `default`: Network {
        return .mainnet
    }
}

public struct Account {
    public var keyPair: KeyPair
    public var address: Address
    public let network: Network
    public var wif:String?
    public var name:String?
    
    public init(keyPair: KeyPair, network: Network = .default){
        self.keyPair = keyPair
        self.address = Address(keyPair: keyPair, network: network)
        self.network = network
    }
    //import from wif
    public init(wif:String, network: Network = .default) throws{
        self.wif = wif
        let privateKeyData = Address.WifToPrivateKey(wif: wif)
        let privateKey = PrivateKey(base64: privateKeyData!)
        self.keyPair = KeyPair(privateKeyHex: ((privateKey?.asHex())!))!
        self.address = Address(keyPair: keyPair, network: network)
        self.network = network
    }
    //import from private key
    public init(privateKeyHex: String, network: Network = .default){
        self.keyPair = KeyPair(privateKeyHex: privateKeyHex)!
        self.address = Address(keyPair: keyPair, network: network)
        self.network = network
    }
}

public extension Account{
    //encrypt method
    public func encrypt(password:String) throws -> String? {
        let n = 4096
        let r = 8
        let p = 8
        let dkLen = 64

        let salt:Data = try!Data(bytes: EllipticCurveKit.securelyGenerateBytes(count: 16))
        var keystore = [
        "type": "A",
        "label": name as Any,
        "address": address.addressStr
        ] as [String:Any]
        let scryptDic = [
            "r": String(r),
            "p": String(p),
            "n": String(n),
            "dkLen": String(dkLen)
        ]
        let parameters = [
            "curve": "P-256"
        ]
        keystore["parameters"] = parameters
        keystore["scrypt"] = scryptDic
        keystore["salt"] = String(data: salt.base64EncodedData(), encoding: .utf8)
        let passwordData = password.precomposedStringWithCompatibilityMapping.data(using: .utf8)
        //Scrypt
        let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen, N: n, r: r, p: p).calculate()
        if status.count != dkLen {
            return nil
        }
        let derivedkey = Data(bytes: status)
        let derivedhalf2 = derivedkey.subdata(in: 31...63)
        let iv = derivedkey.subdata(in: 0...11)
        
        //AES-GSM
        let aad:Data = address.addressStr .data(using: .utf8)!
        let gcm = GCM(iv: iv.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
        do {
            let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
            let cipheredData = try aes.encrypt(keyPair.privateKey.asData.bytes)
            //let tag = gcm.authenticationTag
            let key = Data(bytes: cipheredData)
            keystore["key"] = key.base64EncodedData()
            
        } catch{
            throw ErrorCode.EncriptPrivateKeyError
        }
        guard let data:Data = try JSONSerialization.data(withJSONObject: keystore, options: .prettyPrinted) else {
            return nil
        }

        return data.toHexString()
    }
}





