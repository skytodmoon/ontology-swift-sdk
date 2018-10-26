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
        let gen = AnyKeyGenerator<Secp256r1>.generateNewKeyPair()
        print(gen.publicKey)
        print(gen.privateKey)
        
        let address = Address(keyPair: gen, network: .default)
        print(address)
        let act = Account.init(keyPair: gen, network: .default)
        do {
            let jsonStr = try act.encrypt(password: address.addressStr)
            print(jsonStr as Any)
        } catch {
            print("error")
        }

            //Address(hexString: "9CA91EB535FB92FDA5094110FDAEB752EDB9B039")

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

