//
//  Curve.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/28.
//  Copyright © 2018年 com.wm. All rights reserved.
//

enum Curve{
    case P224
    case P256
    case P384
    case P521
    case SM2P256V1
    case ED25519
    func getCurve() -> CurveModel {
        switch self {
        case .P224:
            return CurveModel(v0: 1, v1: "P224")
        case .P256:
            return CurveModel(v0: 2, v1: "P256")
        case .P384:
            return CurveModel(v0: 3, v1: "P384")
        case .P521:
            return CurveModel(v0: 4, v1: "P521")
        case .SM2P256V1:
            return CurveModel(v0: 20, v1: "SM2P256V1")
        case .ED25519:
            return CurveModel(v0: 25, v1: "ED25519")
        }
    }
    func getCurveStr() -> String {
        return getCurve().v1
    }

}

