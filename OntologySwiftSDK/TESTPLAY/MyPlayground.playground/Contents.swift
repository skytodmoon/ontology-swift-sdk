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
let gen = AnyKeyGenerator<Secp256r1>.generateNewKeyPair()
print(gen.publicKey)
print(gen.privateKey)

var str = "Hello, playground"
let n = 4096
let r = 8
let p = 8
let dkLen = 64
let stop = 0
let name = "sq"
let password = "sasd32e1jkjk"
let salt:Data = try!Data(bytes: EllipticCurveKit.securelyGenerateBytes(count: 16))
let addressStr = "dhjklDd82hoD52hjkddhjklDd82hoD52hjkd"
var keystore = [
    "type": "A",
    "label": name as Any,
    "address": addressStr
    ] as [String:Any]
let scryptDic = [
    "r": String(r),
    "p": String(p),
    "n": String(n),
    "dkLen": String(dkLen)
]
let parameters = [
    "curve": "P-256"
]
keystore["parameters"] = parameters
keystore["scrypt"] = scryptDic
let saltStr = String(data: salt.base64EncodedData(), encoding: String.Encoding.utf8)
keystore["salt"] = saltStr
keystore["algorithm"] = "ECDSA"
let passwordData = password.precomposedStringWithCompatibilityMapping.data(using: String.Encoding.utf8)

let status:Array<UInt8> = try!Scrypt.init(password: (passwordData?.bytes)!, salt: salt.bytes, dkLen: dkLen, N: n, r: r, p: p).calculate()
print(status as Any,status.count)
//checked
if status.count != dkLen {
    print("error")
}
let derivedkey = Data(bytes: status)
let derivedhalf2 = derivedkey.subdata(in: 32...63)
print(derivedhalf2.count)
let iv = derivedkey.subdata(in: 0...11)

//AES-GSM
let aad:Data = addressStr .data(using: .utf8)!
let gcm = GCM(iv: iv.bytes, additionalAuthenticatedData: aad.bytes, mode: .combined)
do {
    let aes = try AES(key: derivedhalf2.bytes, blockMode: gcm, padding: .noPadding)
    print(gen.privateKey.asData.bytes , gen.privateKey.asData.bytes.count)
    let cipheredData = try aes.encrypt(gen.privateKey.asData.bytes)
    //let tag = gcm.authenticationTag
    let key = Data(bytes: cipheredData)
    keystore["key"] = key.base64EncodedString()
    print(key.base64EncodedString().count)

} catch{
    print("ErrorCode.EncriptPrivateKeyError1")
}
print(keystore)
let testKey = "FgnNWTxS7Nu76t3YgZAOWNcrWQQF9O+aj9vPlY2W4/+kvTwZT04bRqcieGQ3wqFT"
print(testKey.count)


