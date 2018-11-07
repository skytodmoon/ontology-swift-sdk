//
//  Ont.swift
//  OntologySwiftSDK
//
//  Created by SH-JRY-0073 on 2018/10/10.
//  Copyright © 2018年 孙琦. All rights reserved.
//

import Foundation
import EllipticCurveKit

public struct Ont: DistributedSystem {
    public typealias Network = Bitcoin.Network
    public let network: Network
    public struct WIF: WIFFormatter {
        public typealias System = Ont
    }
    
    public let wifFormatter = WIF()
    public init(_ network: Network) {
        self.network = network
    }
    
}

public extension Ont {
    typealias Curve = Secp256r1
    
    func addressHashForOnt(of data: Data) -> String{
        //ont address method
        
        let CHECKSIG:[Byte] = [0xAC]
        let mData:NSMutableData = NSMutableData.init()
        mData .pushData(data: data)
        mData.append(CHECKSIG, length: 1)
        let hash160 =  Crypto.sha2Sha256_ripemd160(mData as Data)
        return Address.hash160ToAddress(data: hash160)
    }
    
}
