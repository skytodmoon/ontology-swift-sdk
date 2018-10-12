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
    
    func addressHash(of data: Data) -> String{
        //ont address method
        
        let CHECKSIG:[Byte] = [0xAC]
        let program = data + Data(bytes: CHECKSIG, count: 1)
        let COIN_VERSION:[Byte] = [0x17]
        let addressTagData = Data(bytes: COIN_VERSION, count: 1)
        let hexData = addressTagData + Crypto.sha2Sha256_ripemd160(program)

        return Address.base58checkWithData(data:hexData)
    }
    
}
