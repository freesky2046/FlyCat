//
//  FCMobileNetworkManager.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/23.
//

import UIKit
import Alamofire
import SwiftyJSON

struct LoginToken: Codable {
    let mid: Int
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    var expireDate: Date?
}

enum RequestError: Error {
    case networkFail
    case statusFail(code: Int, message: String)
    case decodeFail(message: String)
}


class FCMobileNetworkManager: NSObject {

    private static let appKey = "4409e2ce8ffd12b8"
    private static let appSecret = "59b43e04ad6965f34319062b478f83dd"
    
    static func request(_ url:URLConvertible,
                        method:HTTPMethod = .get,
                        parameters:Parameters = [:],
                        encoding: ParameterEncoding = URLEncoding.default,
                        complete: ((Result<JSON, RequestError>) -> Void)? = nil)
    {
        var p = parameters;
        p["access_key"] = userToken()?.accessToken
        AF.request(url, method: method, parameters: p, encoding: encoding).responseData { response in
            
        }
    }
    
    static func userToken() -> LoginToken? {
        if let token: LoginToken =  UserDefaults.standard.codeable(forKey: "Token") {
            return token
        }else {
            return nil
        }
    }

}
