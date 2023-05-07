//
//  FCConstant.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/5.
//

import Foundation
import UIKit

struct FCConstant {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let headline = 38.0
    static func appName() -> String {
        if let name =  Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return name
        }else {
            return "FlyCat"
        }
    }
    static func appVersion() -> String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return version
        }else {
            return  "1.0.0"
        }
    }
    static let sysName =  UIDevice.current.systemName
    static let sysVersion = UIDevice.current.systemVersion
    
    static func userAgent() -> String {
        var str:String = String()
        let name = appName()
        let version = appVersion()
        str = "xpanvideo; \(name); \(version);\(sysName);\(sysVersion)"
        return str
    }
}
