//
//  Account.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//
import EllipticCurveKit

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





