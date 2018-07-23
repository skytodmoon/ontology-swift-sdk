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
    //func getRawTransaction(txhash: String) throws ->Transaction?
}


//String getUrl();
//Object sendRawTransaction(boolean preExec,String userid,String hexData) throws ConnectorException, IOException;
//Object sendRawTransaction(String hexData) throws ConnectorException, IOException;
//Transaction getRawTransaction(String txhash) throws ConnectorException, IOException;
//Object getRawTransactionJson(String txhash) throws ConnectorException, IOException;
//int getGenerateBlockTime() throws ConnectorException, IOException;
//int getNodeCount() throws ConnectorException, IOException;
//int getBlockHeight() throws ConnectorException, IOException;
//Block getBlock(int height) throws ConnectorException, IOException;
//Block getBlock(String hash) throws ConnectorException, IOException ;
//Object getBlockJson(int height) throws ConnectorException, IOException;
//Object getBlockJson(String hash) throws ConnectorException, IOException;
//
//Object getBalance(String address) throws ConnectorException, IOException;
//
//Object getContract(String hash) throws ConnectorException, IOException;
//Object getContractJson(String hash) throws ConnectorException, IOException;
//Object getSmartCodeEvent(int height) throws ConnectorException, IOException;
//Object getSmartCodeEvent(String hash) throws ConnectorException, IOException;
//int getBlockHeightByTxHash(String hash) throws ConnectorException, IOException;
//
//String getStorage(String codehash,String key) throws ConnectorException, IOException;
//Object getMerkleProof(String hash) throws ConnectorException, IOException;
//String getAllowance(String asset,String from,String to) throws ConnectorException, IOException;
//Object getMemPoolTxCount() throws ConnectorException, IOException;
//Object getMemPoolTxState(String hash) throws ConnectorException, IOException;
//String getVersion() throws ConnectorException, IOException;
