//
//  ErrorCode.swift
//  ontology-swift-sdk
//
//  Created by SH-JRY-0073 on 2018/7/24.
//  Copyright © 2018年 com.wm. All rights reserved.
//
import Foundation
enum ErrorCode: Error{
    //account error
    case InvalidParams
    case UnsupportedKeyType
    case InvalidMessage
    case WithoutPrivate
    case InvalidSM2Signature
    case AccountInvalidInput
    case AccountWithoutPublicKey
    case UnknownKeyType
    case NullInput
    case InvalidData
    case Decoded3bytesError
    case DecodePrikeyPassphraseError
    case encryptedPriKeyAddressPasswordErr
    case PrikeyLengthError
    case EncryptedPriKeyError
    case EncriptPrivateKeyError
    //
    case ParamLengthErr
    case ChecksumNotValidate
    case InputTooShort
    case UnknownCurve
    case UnknownCurveLabel
    case UnknownAsymmetricKeyType
    case InvalidSignatureData
    case InvalidSignatureDataLen
    case MalformedSignature
    case UnsupportedSignatureScheme
    case DataSignatureErr
    case UnSupportOperation
    //Core Error
    case TxDeserializeError
    case BlockDeserializeError
    //merkle error
    case MerkleVerifierErr
    case TargetHashesErr
    case ConstructedRootHashErr
    case AsserFailedHashFullTree
    case LeftTreeFull
    //SmartCodeTx Error
    case SendRawTxError
    case TypeError
    //OntIdTx Error
    case NullCodeHash
    case ParamError
    case ParamErr
    case DidNull
    case NotExistCliamIssuer
    case NotFoundPublicKeyId
    case PublicKeyIdErr
    case BlockHeightNotMatch
    case NodesNotMatch
    case ResultIsNull
    case CreateOntIdClaimErr
    case VerifyOntIdClaimErr
    case WriteVarBytesError
    case SendRawTransactionPreExec
    case SenderAmtNotEqPasswordAmt
    case ExpireErr
    case GetStatusErr
    //OntAsset Error
    case AssetNameError
    case DidError
    case NullPkId
    case NullClaimId
    case AmountError
    case ParamLengthNotSame
    //RecordTx Error
    case NullKeyOrValue
    case NullKey
    //OntSdk Error
    case WebsocketNotInit
    case ConnRestfulNotInit
    //abi error
    case SetParamsValueValueNumError
    case ConnectUrlError
    case ConnectUrlErr
    //WalletManager Error
    case GetAccountByAddressErr
    case OtherError

    
    func withErrorStr(message: String) -> String {
        switch self {
        //account error
        case .InvalidParams:
            return getError(code: 51001, msg: "Account Error,invalid params")
        case .UnsupportedKeyType:
            return getError(code: 51002, msg: "Account Error,unsupported key type")
        case .InvalidMessage:
            return getError(code: 51003, msg: "Account Error,invalid message")
        case .WithoutPrivate:
            return getError(code: 51004, msg: "Account Error,account without private key cannot generate signature")
        case .InvalidSM2Signature:
            return getError(code: 51005, msg: "Account Error,invalid SM2 signature parameter, ID (String) excepted")
        case .AccountInvalidInput:
            return getError(code: 51006, msg: "Account Error,account invalid input")
        case .AccountWithoutPublicKey:
            return getError(code: 51007, msg: "Account Error,account without public key cannot verify signature")
        case .UnknownKeyType:
            return getError(code: 51008, msg: "Account Error,unknown key type")
        case .NullInput:
            return getError(code: 51009, msg: "Account Error,null input")
        case .InvalidData:
            return getError(code: 51010, msg: "Account Error,invalid data")
        case .Decoded3bytesError:
            return getError(code: 51011, msg: "Account Error,decoded 3 bytes error")
        case .DecodePrikeyPassphraseError:
            return getError(code: 51012, msg: "Account Error,decode prikey passphrase error")
        case .PrikeyLengthError:
            return getError(code: 51013, msg: "Account Error,Prikey length error")
        case .EncryptedPriKeyError:
            return getError(code: 51014, msg: "Account Error,Prikey length error")
        case .encryptedPriKeyAddressPasswordErr:
            return getError(code: 51015, msg: "Account Error,encryptedPriKey address password not match")
        case .EncriptPrivateKeyError:
            return getError(code: 51016, msg: "Account Error, encript privatekey error")
        //
        case .ParamLengthErr:
            return getError(code: 52001, msg: "Uint256 Error,param length error")
        case .ChecksumNotValidate:
            return getError(code: 52002, msg: "Base58 Error,Checksum does not validate")
        case .InputTooShort:
            return getError(code: 52003, msg: "Base58 Error,Input too short")
        case .UnknownCurve:
            return getError(code: 52004, msg: "Curve Error,unknown curve")
        case .UnknownCurveLabel:
            return getError(code: 52005, msg: "Curve Error,unknown curve label")
        case .UnknownAsymmetricKeyType:
            return getError(code: 52006, msg: "keyType Error,unknown asymmetric key type")
        case .InvalidSignatureData:
            return getError(code: 52007, msg: "Signature Error,invalid signature data: missing the ID parameter for SM3withSM2")
        case .InvalidSignatureDataLen:
            return getError(code: 52008, msg: "Signature Error,invalid signature data length")
        case .MalformedSignature:
            return getError(code: 52009, msg: "Signature Error,malformed signature")
        case .UnsupportedSignatureScheme:
            return getError(code: 52010, msg: "Signature Error,unsupported signature scheme")
        case .DataSignatureErr:
            return getError(code: 52011, msg: "Signature Error,Data signature error")
        case .UnSupportOperation:
            return getError(code: 52012, msg: "Address Error, UnsupportedOperationException")
        //Core Error
        case .TxDeserializeError:
            return getError(code: 53001, msg: "Core Error,Transaction deserialize failed")
        case .BlockDeserializeError:
            return getError(code: 53002, msg: "Core Error,Block deserialize failed")
        //merkle error
        case .MerkleVerifierErr:
            return getError(code: 54001, msg: "Wrong params: the tree size is smaller than the leaf index")
        case .TargetHashesErr:
            return getError(code: 54002, msg: "targetHashes error")
        case .ConstructedRootHashErr:
            return getError(code: 54003, msg: "Other Error," + message)
        case .AsserFailedHashFullTree:
            return getError(code: 54004, msg: "assert failed in hash full tree")
        case .LeftTreeFull:
            return getError(code: 54005, msg: "left tree always full")
        //SmartCodeTx Error
        case .SendRawTxError:
            return getError(code: 58001, msg: "SmartCodeTx Error,sendRawTransaction error")
        case .TypeError:
            return getError(code: 58002, msg: "SmartCodeTx Error,type error")
        //OntIdTx Error
        case .NullCodeHash:
            return getError(code: 58003, msg: "OntIdTx Error,null codeHash")
        case .ParamError:
            return getError(code: 58004, msg: "param error")
        case .ParamErr:
            return getError(code: 58005, msg: message)
        case .DidNull:
            return getError(code: 58006, msg: "OntIdTx Error,SendDid or receiverDid is null in metaData")
        case .NotExistCliamIssuer:
            return getError(code: 58007, msg: "OntIdTx Error,Not exist cliam issuer")
        case .NotFoundPublicKeyId:
            return getError(code: 58008, msg: "OntIdTx Error,not found PublicKeyId")
        case .PublicKeyIdErr:
            return getError(code: 58009, msg: "OntIdTx Error,PublicKeyId err")
        case .BlockHeightNotMatch:
            return getError(code: 58010, msg: "OntIdTx Error,BlockHeight not match")
        case .NodesNotMatch:
            return getError(code: 58011, msg: "OntIdTx Error,nodes not match")
        case .ResultIsNull:
            return getError(code: 58012, msg: "OntIdTx Error,result is null")
        case .CreateOntIdClaimErr:
            return getError(code: 58013, msg: "OntIdTx Error, createOntIdClaim error")
        case .VerifyOntIdClaimErr:
            return getError(code: 58014, msg: "OntIdTx Error, verifyOntIdClaim error")
        case .WriteVarBytesError:
            return getError(code: 58015, msg: "OntIdTx Error, writeVarBytes error")
        case .SendRawTransactionPreExec:
            return getError(code: 58016, msg: "OntIdTx Error, sendRawTransaction PreExec error")
        case .SenderAmtNotEqPasswordAmt:
            return getError(code: 58017, msg: "OntIdTx Error, senders amount is not equal password amount")
        case .ExpireErr:
            return getError(code: 58017, msg: "OntIdTx Error, expire is wrong")
        case .GetStatusErr:
            return getError(code: 58017, msg: "GetStatus Error," + message)
        //OntAsset Error
        case .AssetNameError:
            return getError(code: 58101, msg: "OntAsset Error,asset name error")
        case .DidError:
            return getError(code: 58102, msg: "OntAsset Error,Did error")
        case .NullPkId:
            return getError(code: 58103, msg: "OntAsset Error,null pkId")
        case .NullClaimId:
            return getError(code: 58104, msg: "OntAsset Error,null claimId")
        case .AmountError:
            return getError(code: 58105, msg: "OntAsset Error,amount or gas is less than or equal to zero")
        case .ParamLengthNotSame:
            return getError(code: 58105, msg: "OntAsset Error,param length is not the same")
        //RecordTx Error
        case .NullKeyOrValue:
            return getError(code: 58201, msg: "RecordTx Error,null key or value")
        case .NullKey:
            return getError(code: 58202, msg: "RecordTx Error,null  key")
        //OntSdk Error
        case .WebsocketNotInit:
            return getError(code: 58301, msg: "OntSdk Error,websocket not init")
        case .ConnRestfulNotInit:
            return getError(code: 58302, msg: "OntSdk Error,connRestful not init")
        //abi error
        case .SetParamsValueValueNumError:
            return getError(code: 58401, msg: "AbiFunction Error,setParamsValue value num error")
        case .ConnectUrlError:
            return getError(code: 58402, msg: "Interfaces Error,connect error:")
        case .ConnectUrlErr:
            return getError(code: 58403, msg: "connect error:" + message)
        //WalletManager Error
        case .GetAccountByAddressErr:
            return getError(code: 58501, msg: "WalletManager Error,getAccountByAddress err")
        case .OtherError:
            return getError(code: 59000, msg: "Other Error," + message)
        }
    }
    func getError(code: Int, msg: String) -> String {
        let dic = ["Error": code,"Desc": msg] as [String : Any]
        if let jsonData = try? JSONEncoder().encode(dic)  {
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print("----------------Base--------------------")
                return jsonString
            }
        }
    }
}
