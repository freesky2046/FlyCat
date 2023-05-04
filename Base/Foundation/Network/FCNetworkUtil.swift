//
//  FCMobileNetworkManager.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/23.
//

import UIKit
import Alamofire
//import SwiftyJSON
import HandyJSON


struct FCNetworkSecret {
    fileprivate static let appKey = "GQIAYSFI6CYhW6SYibIc0aFaqanEFwEI"
    fileprivate static let scope = "basic,netdisk"
}

struct FCUrl {
    static let deviceCode = "https://openapi.baidu.com/oauth/2.0/device/code"
    static let getToken = "https://openapi.baidu.com/oauth/2.0/token"
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
                        complete: ((Result<String, AFError>) -> Void)? = nil)
    {
        var p = parameters;
        if(needAuth) {
            p["access_key"] = userToken()?.access_token
        }
        p["client_id"] = FCNetworkSecret.appKey;
        p["scope"] = FCNetworkSecret.scope;

        AF.request(url, method: method, parameters: p, encoding: encoding, headers: nil, interceptor: nil, requestModifier: nil).responseString { response in
            switch response.result {
            case .success(let data):
                complete?(.success(data))
            case .failure(let error):
                complete?(.failure(error))
            }
        };
    }
    
    static func userToken() -> FCTokenInfo? {
        if let token: FCTokenInfo =  UserDefaults.standard.codeable(forKey: "flycat.token") {
            return token
        }else {
            return nil
        }
    }

}
