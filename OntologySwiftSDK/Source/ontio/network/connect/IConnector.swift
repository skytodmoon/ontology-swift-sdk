//
//  IConnector.swift
//  ontology-swift-sdk
//
//  Created by 孙琦 on 2018/7/23.
//  Copyright © 2018年 孙琦. All rights reserved.
//

protocol IConnector{
    func getUrl() -> String?
    func sendRawTransaction(preExec: Bool, userid: String, hexData: String) throws ->Any?
    func sendRawTransaction(hexData: String) throws ->Any?
    func getRawTransaction(txhash: String) throws ->Transaction?
    func getRawTransactionJson(txhash: String) throws ->Any?
    func getGenerateBlockTime() throws ->Int?
    func getNodeCount() throws ->Int?
    func getBlockHeight() throws ->Int?
//    func getBlock(height: Int) throws ->Block?
//    func getBlock(hash: String) throws ->Block?
    func getBlockJson(height: Int) throws ->Any?
    func getBlockJson(hash: String) throws ->Any?
    func getBalance(address: String) throws ->Any?
    func getContract(hash: String) throws ->Any?
    func getContractJson(hash: String) throws ->Any?
    func getSmartCodeEvent(height: Int) throws ->Any?
    func getSmartCodeEvent(hash: String) throws ->Any?
    func getBlockHeightByTxHash(hash: String) throws ->Int?
    func getStorage(codehash: String,key: String) throws -> String?
    func getMerkleProof(hash: String) throws ->Any?
    func getAllowance(asset: String,from: String,to: String) ->String?
    func getMemPoolTxCount() throws ->Any?
    func getMemPoolTxState(hash: String) throws -> Any?
    func getVersion() throws ->String?
}

