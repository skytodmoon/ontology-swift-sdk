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
    
    func addressHash(of data: Data) -> Data{
        let hash = Crypto.sha2Sha256(data)
        return hash.suffix(20)
    }
}
