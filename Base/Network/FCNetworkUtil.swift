//
//  FCMobileNetworkManager.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/23.
//

import UIKit
import Alamofire
import SwiftyJSON


struct FCNetworkSecret {
    fileprivate static let appKey = "GQIAYSFI6CYhW6SYibIc0aFaqanEFwEI"
    fileprivate static let scope = "basic,netdisk"
}

struct FCUrl {
    static let deviceCode = "https://openapi.baidu.com/oauth/2.0/device/code"
}

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


class FCNetworkUtil  {
    static func request(_ url:URLConvertible,
                        method:HTTPMethod = .get,
                        parameters:Parameters = [:],
                        needAuth:Bool = true,
                        encoding: ParameterEncoding = URLEncoding.default,
                        complete: ((Result<JSON, RequestError>) -> Void)? = nil)
    {
        var p = parameters;
        if(needAuth) {
            p["access_key"] = userToken()?.accessToken
        }
        p["client_id"] = FCNetworkSecret.appKey;
        p["scope"] = FCNetworkSecret.scope;
        AF.request(url, method: method, parameters: p, encoding: encoding).responseData { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                print(json)
                complete?(.success(json))
            case let .failure(err):
                print(err)
                complete?(.failure(.networkFail))
            }
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
