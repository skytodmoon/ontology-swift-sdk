//
//  SignatureScheme.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/25.
//  Copyright © 2018年 com.wm. All rights reserved.
//

enum SignatureScheme: String{
    case SHA224WITHECDSA = "SHA224withECDSA"
    case SHA256WITHECDSA = "SHA256withECDSA"
    case SHA384WITHECDSA = "SHA384withECDSA"
    case SHA3_224WITHECDSA = "SHA3-224withECDSA"
    case SHA3_256WITHECDSA = "SHA3-256withECDSA"
    case SHA3_384WITHECDSA = "SHA3-384withECDSA"
    case SHA3_512WITHECDSA = "SHA3-512withECDSA"
    case RIPEMD160WITHECDSA = "RIPEMD160withECDSA"
    case SM3WITHSM2 = "SM3withSM2"
    
    var name: String {
        return rawValue
    }
    
    static func fromScheme(name: String) throws -> SignatureScheme{
        guard let tempScheme = SignatureScheme(rawValue: name)
            else { throw ErrorCode.UnknownAsymmetricKeyType }
        return tempScheme
    }
    
}
