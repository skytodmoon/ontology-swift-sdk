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


public struct Account {
    public let keyPair: KeyPair
    public let address: Address
    public let network: Network
    
    public init() throws {
        self.keyPair = AnyKeyGenerator<Curve>.generateNewKeyPair()
//        guard let wallet = Wallet.init(keyPair: (keyPair)self.keyPair , system: Ont) else {
//            throw ErrorCode.GetAccountByAddressErr
//        }
    }
//    fileprivate var keyType: KeyType?
//    fileprivate var curveParams:[Any]?
//    fileprivate var privateKeyStr:String?
//    fileprivate var publicKeyStr:String?
//    fileprivate var addressU160:Address?
//    fileprivate var signatureScheme:SignatureScheme?
    
    // create an account with the specified key type
//    init(scheme: SignatureScheme) throws {
//    signatureScheme = scheme
//        if scheme == SignatureScheme.SHA256WITHECDSA {
//            keyType = KeyType.ECDSA
//            curveParams = [Curve.P256.getCurveStr()]
//        }else if scheme == SignatureScheme.SM3WITHSM2{
//            keyType = KeyType.SM2
//            curveParams = [Curve.SM2P256V1.getCurveStr()]
//        }
//
//        switch scheme {
//        case SignatureScheme.SHA256WITHECDSA,SignatureScheme.SM3WITHSM2:
//            if !(curveParams![0] is String){
//                throw ErrorCode.InvalidParams
//            }
//
//
//        default:
//            throw ErrorCode.UnsupportedKeyType
//        }
//    }
}


