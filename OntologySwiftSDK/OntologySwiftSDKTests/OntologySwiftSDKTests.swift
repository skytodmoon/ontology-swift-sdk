//
//  OntologySwiftSDKTests.swift
//  OntologySwiftSDKTests
//
//  Created by 孙琦 on 2018/10/2.
//  Copyright © 2018年 孙琦. All rights reserved.
//

import XCTest
import EllipticCurveKit
@testable import OntologySwiftSDK

class OntologySwiftSDKTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        print("sdasda")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let gen = AnyKeyGenerator<Secp256r1>.generateNewKeyPair()
            print(gen.privateKey)
            // Put the code you want to measure the time of here.
        }
    }
    
}
