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
        let privateKey = PrivateKey(hex: privateKeyStr)
 //       let act = Account.init(privateKeyHex: (privateKey?.asHex())!, network: .default)
        let keypair = KeyPair.init(privateKeyHex: privateKeyStr)
        print(keypair?.publicKey.data.compressed.toHexString() as Any)
        print(keypair?.privateKey.asHex() as Any)
        do {
            let address = try Address.init(keyPair: keypair!, network: .default)
            print(address.addressStr)

        } catch {
            print(error)
        }
        //let address = Address.init(keyPair: keypair!, network: .default)
//        let act = Account.init(privateKeyHex: "6fn6KFrpXTeLQUTus82IW56mOf9zfCzsYenbbtlHGv6GD1y3q5PV3pD2LQRh7iPQ", network: .default)
//        print(act.address.addressStr)
//let act = Account.init(privateKeyHex: "")\
//        do {
//            let address = try Address.init(uncheckedAddressString: "AXvprchw69nAgGakuiyM9CUFNdsU3v1bj1")
//            print(address?.addressStr as Any)
//            print(address?.publicKeyHash160 as Any)
//        } catch {
//            print(error)
//        }
//        let address1 = "3AGpYddv35FmLKV3FDEDijUUGn4HS29B5"
//        let address2 = "AXvprchw69nAgGakuiyM9CUFNdsU3v1bj1"
//        print(address1.count,address2.count)
//        let hash160 = Address.addressToHash160(uncheckStr: "AXvprchw69nAgGakuiyM9CUFNdsU3v1bj1")
//
//        let addressStr = Address.hash160ToAddress(data: hash160!)
//        print(hash160 as Any)
//        print(addressStr)
        

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

