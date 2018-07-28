//
//  Account.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//

public class Account {
    fileprivate var keyType: KeyType?
    fileprivate var curveParams:[AnyObject]?
    fileprivate var privateKeyStr:String?
    fileprivate var publicKeyStr:String?
    fileprivate var addressU160:Address?
    fileprivate var signatureScheme:SignatureScheme?
}
