//
//  Account.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//
public class Account {
    fileprivate var keyType: KeyType?
    fileprivate var curveParams:[Any]?
    fileprivate var privateKeyStr:String?
    fileprivate var publicKeyStr:String?
    fileprivate var addressU160:Address?
    fileprivate var signatureScheme:SignatureScheme?
    
    // create an account with the specified key type
    init(scheme: SignatureScheme) throws {
    signatureScheme = scheme
        if scheme == SignatureScheme.SHA256WITHECDSA {
            keyType = KeyType.ECDSA
            curveParams = [Curve.P256.getCurveStr()]
        }else if scheme == SignatureScheme.SM3WITHSM2{
            keyType = KeyType.SM2
            curveParams = [Curve.SM2P256V1.getCurveStr()]
        }
        
        switch scheme {
        case SignatureScheme.SHA256WITHECDSA,SignatureScheme.SM3WITHSM2:
            if !(curveParams![0] is String){
                throw ErrorCode.InvalidParams
            }
            
            
        default:
            throw ErrorCode.UnsupportedKeyType
        }
    }
}
