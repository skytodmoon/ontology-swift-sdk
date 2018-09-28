//
//  CurveModel.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/28.
//  Copyright © 2018年 com.wm. All rights reserved.
//

public struct CurveModel{
    var v0: Int
    var v1: String
    init(v0:Int,v1:String) {
        self.v0 = v0
        self.v1 = v1
    }
    public func getV0() -> Int{
        return v0
    }
    public func getV1() -> String{
        return v1
    }
}


