import UIKit
import scrypt
import EllipticCurveKit
import CryptoSwift
public extension Data
{
    public func subdata(in range: CountableClosedRange<Data.Index>) -> Data
    {
        return self.subdata(in: range.lowerBound..<range.upperBound + 1)
    }
}

public extension Dictionary {
    
    func toJSONString() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let json = String(data: data, encoding: String.Encoding.utf8) {
                return json
            }
        }
        
        return nil
    }
}

public extension String{
    func convertStringToDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}



//let gen = AnyKeyGenerator<Secp256r1>.generateNewKeyPair()
//print(gen.publicKey)
//print(gen.privateKey)
//var str = "Hello, playground"
//let n = 4096
//let r = 8
//let p = 8
//let dkLen = 64
//let stop = 0
//let name = "sq"
//let password = "sasd32e1jkjk"
//let salt:Data = try!Data(bytes: EllipticCurveKit.securelyGenerateBytes(count: 16))
//let addressStr = "dhjklDd82hoD52hjkddhjklDd82hoD52hjkd"
//var keystore = [
//    "type": "A",
//    "label": name as Any,
//    "address": addressStr
//    ] as [String:Any]
//let scryptDic = [
//    "r": String(r),
//    "p": String(p),
//    "n": String(n),
//    "dkLen": String(dkLen)
//]
//let parameters = [
//    "curve": "P-256"
//]
//keystore["parameters"] = parameters
//keystore["scrypt"] = scryptDic
//let saltStr = String(data: salt.base64EncodedData(), encoding: String.Encoding.utf8)
//keystore["salt"] = saltStr
//keystore["algorithm"] = "ECDSA"
//let passwordData = password.precomposedStringWithCompatibilityMapping.data(using: String.Encoding.utf8)
//
//let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen, N: n, r: r, p: p).calculate()
//print(status as Any,status.count)
////checked
//if status.count != dkLen {
//    print("error")
//}
//let derivedkey = Data(bytes: status)
//let derivedhalf2 = derivedkey.subdata(in: 32...63)
//print(derivedhalf2.count)
//let iv = derivedkey.subdata(in: 0...11)
//
////AES-GSM
//let aad:Data = addressStr .data(using: .utf8)!
//let gcm = GCM(iv: iv.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
//do {
//    let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
//    print(gen.privateKey.asData.bytes , gen.privateKey.asData.bytes.count)
//    let cipheredData = try aes.encrypt(gen.privateKey.asData.bytes)
//    //let tag = gcm.authenticationTag
//    let key = Data(bytes: cipheredData)
//    print(key.count)
//    keystore["key"] = key.base64EncodedString()
//    print(key.base64EncodedString().count)
//
//} catch{
//    print("ErrorCode.EncriptPrivateKeyError1")
//}
//print(keystore)
//let testKey = "6PYM8jauFEDsk2S5VS9S7tDKzBfkZJRXJkeStZ1yYiTWkULSndyq7xoF6T"
//print(testKey.count)

let keystore = "{\"algorithm\":\"ECDSA\",\"salt\":\"HL\\/tUrs2\\/n9nFbDTUyJKwg==\",\"key\":\"V0L058Ds47pe546y3YSaZD7TvHSGKwLdDMnB\\/rTEWokboM91FW6wuHetGBbisINS\",\"address\":\"AVamZCtMtdYimby7kVfAs9Z79aeRS2zGud\",\"label\":null,\"scrypt\":{\"p\":\"8\",\"n\":\"4096\",\"r\":\"8\",\"dkLen\":\"64\"},\"parameters\":{\"curve\":\"P-256\"},\"type\":\"A\"}"
let keystoreDic:Dictionary = keystore.convertStringToDictionary()!
guard keystoreDic["address"] != nil &&
    keystoreDic["salt"] != nil &&
    keystoreDic["key"] != nil &&
    keystoreDic["type"] != nil &&
    keystoreDic["algorithm"] != nil &&
    keystoreDic["scrypt"] != nil &&
    keystoreDic["type"] as! String == "A" &&
    keystoreDic["algorithm"] as! String == "ECDSA"
    else {
      abort()
   }
var name:String?
var password:String = "19860502"
if name == nil && keystoreDic["label"] != nil{
    name = keystoreDic["label"]?.string
}
let scryDic = keystoreDic["scrypt"]
//let nStr =
let n = Int(scryDic!["n"]as! String)
let r = Int(scryDic!["r"]as! String)
let p = Int(scryDic!["p"]as! String)
let dkLen = Int(scryDic!["dkLen"]as! String)


let passwordData = password.precomposedStringWithCompatibilityMapping.data(using: .utf8)
let saltStr = keystoreDic["salt"]as! String
let salt:Data = Data(base64Encoded: saltStr, options: Data.Base64DecodingOptions.init(rawValue: 0))!
let address = keystoreDic["address"]as! String
print(address.count)
let keyStr = keystoreDic["key"]as! String
let key = Data(base64Encoded: keyStr, options: Data.Base64DecodingOptions.init(rawValue: 0))

//Scrypt
let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen!, N: n!, r: r!, p: p!).calculate()
if status.count != dkLen {
    //return nil
}

let derivedkey = Data(bytes: status)

let derivedhalf2 = derivedkey.subdata(in: 32...63)
let iv = derivedkey.subdata(in: 0...11)

//AES-GSM
let encryptedkey:Data = (key?.subdata(in: 0...(key!.count - 16 - 1)))!
let tag:Data = (key?.subdata(in: (key!.count - 16)...key!.count - 1))!
let aad:Data = address.data(using: .utf8)!
let gcm = GCM(iv: iv.bytes, authenticationTag: tag.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
do {
    let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
    let cipheredData = try aes.decrypt(encryptedkey.bytes)
    //let tag = gcm.authenticationTag
    let privateKeyData = Data(bytes: cipheredData).toHexString()
    //keystore["key"] = key.base64EncodedString()
    print(privateKeyData)
} catch{
    print("error2")
    //throw ErrorCode.EncriptPrivateKeyError
}


