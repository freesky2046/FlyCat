//
//  FCDeviceCodeInfo.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/27.
//

import UIKit
import HandyJSON

// demo
//struct BasicTypes: HandyJSON {
//    var int: Int = 2
//    var doubleOptional: Double?
//    var stringImplicitlyUnwrapped: String!
//}
//
//let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
//if let object = BasicTypes.deserialize(from: jsonString) {
//    // …
//}

//{
//    device_code: "984c2459ec41415c9f5b0137a017fc49",
//    user_code: "8drp69hk",
//    verification_url: "https://openapi.baidu.com/device",
//    qrcode_url: "https://openapi.baidu.com/device/qrcode/a52610ef0eec30da5e45870872317478/8drp69hk",
//    expires_in: 300,
//    interval: 5
//}
class FCDeviceCodeInfo: HandyJSON {
    var device_code:String?
    var user_code:String?
    var verification_url:String?
    var qrcode_url:String?
    var expires_in:Int?
    var interval:Int?
    required init() {}
}
