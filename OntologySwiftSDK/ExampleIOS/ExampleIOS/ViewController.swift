//
//  ViewController.swift
//  ExampleIOS
//
//  Created by 孙琦 on 2018/10/2.
//  Copyright © 2018年 孙琦. All rights reserved.
//

import UIKit
import OntologySwiftSDK
import EllipticCurveKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let privateHex = "6fn6KFrpXTeLQUTus82IW56mOf9zfCzsYenbbtlHGv6GD1y3q5PV3pD2LQRh7iPQ"
//        let act = Account.init(privateKeyHex: "6fn6KFrpXTeLQUTus82IW56mOf9zfCzsYenbbtlHGv6GD1y3q5PV3pD2LQRh7iPQ")
        //let privateKey = PrivateKey(base64: "6fn6KFrpXTeLQUTus82IW56mOf9zfCzsYenbbtlHGv6GD1y3q5PV3pD2LQRh7iPQ")
        let privateKeyStr = "ce2f8b3ad44526a2efc7964a297bb27cb8bf9baa088df0f06fcccf1b67ea39d1"
 //       let act = Account.init(privateKeyHex: (privateKey?.asHex())!, network: .default)
        let keypair = KeyPair.init(privateKeyHex: privateKeyStr)
        print(keypair?.publicKey.data.compressed.count as Any)
        print(keypair?.publicKey.hex.compressed as Any)
        print(keypair?.privateKey.asHex() as Any)
        do {
            let address = try Address.init(keyPair: keypair!, network: .default)

            print(address.addressStr)
            print(address.publicKeyHash160)


        } catch {
            print(error)
        }

        //AXvprchw69nAgGakuiyM9CUFNdsU3v1bj1
        //AKg6x2dyXSgSgCi48Sjvxdnic7GsN8h9xV
        //AFwUT12gG5AH2zM7QrzyTRGu6q9NHEHQUo
        

        //let address = Address.init(keyPair: keypair!, network: .default)
//        let act = Account.init(privateKeyHex: "6fn6KFrpXTeLQUTus82IW56mOf9zfCzsYenbbtlHGv6GD1y3q5PV3pD2LQRh7iPQ", network: .default)
//        print(act.address.addressStr)
//let act = Account.init(privateKeyHex: "")\
//        do {
//            let address = try Address.init(uncheckedAddressString: "AXvprchw69nAgGakuiyM9CUFNdsU3v1bj1")
//            print(address?.addressStr as Any)
//            print(address?.publicKeyHash160.bytes as Any)
//        } catch {
//            print(error)
//        }

        

//        let gen = AnyKeyGenerator<Secp256r1>.generateNewKeyPair()
//        print(gen.publicKey)
//        print(gen.privateKey)
//
//        let address = Address(keyPair: gen, network: .default)
//        print(address.addressStr)
//        print(Address.PrivateKeyToWif(privateKey: gen.privateKey) as Any)
//
//        var act = Account.init(keyPair: gen, network: .default)
//        do {
//            let jsonStr = try act.encrypt(password: "19860502")
//            print(jsonStr as Any)
//            let keyStr = try act.decrypt(keystore: jsonStr!)
//            print(keyStr as Any)
//        } catch {
//            print("error")
//        }

            //Address(hexString: "9CA91EB535FB92FDA5094110FDAEB752EDB9B039")

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//public extension NSMutableData{
//    func appendUInt8(value: UInt8) {
//        self.append([value] as [UInt8], length: 1)
//    }
//
//    public func pushData(data:Data){
//        self .appendUInt8(value: UInt8(data.count))
//        //        if data.count <= ONT_OPCODE_PUSHBYTES75 {
//        //
//        //        }
//        self .append(data)
//    }
//}
