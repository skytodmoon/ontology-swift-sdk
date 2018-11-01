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
    public var password:String?
    
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
    //serializePrivateKey
    public func serializePrivateKey() -> [Byte]{
        let privateKeyData = keyPair.privateKey.asData
        if privateKeyData.count == 33 {
            return privateKeyData.subdata(in: 1...privateKeyData.count-1).bytes
        }else if privateKeyData.count == 31{
            return [0]+privateKeyData.bytes
        }else{
            return privateKeyData.bytes
        }
    }
    //serializePublicKey
    public func serializePublicKey() -> [Byte]{
        return keyPair.publicKey.data.compressed.bytes
    }
    //encrypt method
    public mutating func encrypt(password:String) throws -> String? {
        //temp test use
        self.password = password
        let n = 4096
        let r = 8
        let p = 8
        let dkLen = 64

        let salt:Data = try!Data(bytes: EllipticCurveKit.securelyGenerateBytes(count: 16))
        var keystore = [
        "type": "A",
        "label": name as Any,
        "address": address.addressStr
        ] //as [String:Any]
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
        keystore["algorithm"] = "ECDSA"
        keystore["scrypt"] = scryptDic
        keystore["salt"] = String(data: salt.base64EncodedData(), encoding: .utf8)
        let passwordData = password.precomposedStringWithCompatibilityMapping.data(using: .utf8)
        //Scrypt
        let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen, N: n, r: r, p: p).calculate()
        if status.count != dkLen {
            return nil
        }
        let derivedkey = Data(bytes: status)
        let derivedhalf2 = derivedkey.subdata(in: 32...63)
        let iv = derivedkey.subdata(in: 0...11)
        
        //AES-GCM
        let aad:Data = address.addressStr .data(using: .utf8)!
        let gcm = GCM(iv: iv.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
        do {
            let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
            let cipheredData = try aes.encrypt(keyPair.privateKey.asData.bytes)
            //let tag = gcm.authenticationTag
            let key = Data(bytes: cipheredData)
            keystore["key"] = key.base64EncodedString()
            
        } catch{
            throw ErrorCode.EncriptPrivateKeyError
        }

        return keystore.convertDictionaryToString()
    }
    
    public mutating func decrypt(keystore:String) throws -> String?{
        var privateKeyData:String = ""
        let keystoreDic:Dictionary = keystore.convertStringToDictionary()!
        guard keystoreDic["address"] != nil &&
            keystoreDic["salt"] != nil &&
            keystoreDic["key"] != nil &&
            keystoreDic["type"] != nil &&
            keystoreDic["algorithm"] != nil &&
            keystoreDic["scrypt"] != nil &&
            keystoreDic["type"] as! String == "A" &&
            keystoreDic["algorithm"] as! String == "ECDSA"
            else {
            throw ErrorCode.AccountInvalidInput
        }
        if name == nil && keystoreDic["label"] != nil{
            name = keystoreDic["label"]?.string
        }
        let scryDic = keystoreDic["scrypt"]
        let n = Int(scryDic!["n"]as! String)
        let r = Int(scryDic!["r"]as! String)
        let p = Int(scryDic!["p"]as! String)
        let dkLen = Int(scryDic!["dkLen"]as! String)
        let passwordData = password!.precomposedStringWithCompatibilityMapping.data(using: .utf8)
        let saltStr = keystoreDic["salt"]as! String
        let salt:Data = Data(base64Encoded: saltStr, options: Data.Base64DecodingOptions.init(rawValue: 0))!
        let address = keystoreDic["address"]as! String
        let keyStr = keystoreDic["key"]as! String
        let key = Data(base64Encoded: keyStr, options: Data.Base64DecodingOptions.init(rawValue: 0))
        
        //Scrypt
        let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen!, N: n!, r: r!, p: p!).calculate()
        if status.count != dkLen {
            return nil
        }
        
        let derivedkey = Data(bytes: status)
        
        let derivedhalf2 = derivedkey.subdata(in: 32...63)
        let iv = derivedkey.subdata(in: 0...11)
        
        //AES-GCM
        let encryptedkey:Data = (key?.subdata(in: 0...(key!.count - 16 - 1)))!
        let tag:Data = (key?.subdata(in: (key!.count - 16)...key!.count - 1))!
        let aad:Data = address.data(using: .utf8)!
        let gcm = GCM(iv: iv.bytes, authenticationTag: tag.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
        do {
            let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
            let cipheredData = try aes.decrypt(encryptedkey.bytes)
            //let tag = gcm.authenticationTag
            privateKeyData = Data(bytes: cipheredData).toHexString()
            //keystore["key"] = key.base64EncodedString()
            
        } catch{
            throw ErrorCode.EncriptPrivateKeyError
        }
        
        return privateKeyData
    }
    

    


}





