//
//  ErrorCode.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//

enum ErrorCode: Error{
    case InvalidParams = getError(code: 51001, msg: "Account Error,invalid params")

    func getError(code: Int, msg: String) -> String {
        let dic = ["Error": code,"Desc": msg] as [String : Any]
        return dic.description
    }
//    var InvalidParams: String {
//        return getError(code: 51001, msg: "Account Error,invalid params")
//    }
}
