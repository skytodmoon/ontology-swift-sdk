//
//  Curve.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/28.
//  Copyright © 2018年 com.wm. All rights reserved.
//

enum Curve {
    case P224
    case P256
    case P384
    case P521
    case SM2P256V1
    case ED25519
    
    var label:Int?
    var name: String?
}
public struct CurveModelT{
    var v0: Int
    var v1: String
    init(v0:Int,v1:String) {
        self.v0 = v0
        self.v1 = v1
    }
}
