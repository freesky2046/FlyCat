//
//  DataConverter.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/4.
//

import Foundation
import HandyJSON

class DataConverter {
    /// model ---> jsonstring---> data
    static func convert(model:HandyJSON) -> Data {
        if let jsonString = model.toJSONString() {
            if let jsonData = jsonString.data(using: .utf8) {
                // 打印 Data
                return jsonData
            }else {
                return Data.init()
            }
        }else {
            return Data.init()
        }
    }
    
//    static func converTo<T:HandyJSON>(data:Data) -> HandyJSON? {
//        if let str = String(data: data, encoding: .utf8){
//           let result = T.deserialize(from: str)
//           return result
//        }
//        else {
//            return nil
//        }
//    }
    
}
