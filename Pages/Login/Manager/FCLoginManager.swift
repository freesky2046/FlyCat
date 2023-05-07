//
//  FCLoginManager.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/5.
//

import Foundation
import UIKit

class FCLoginManager {
    static let sharedInstance = FCLoginManager()
    
    private init() {
        // 初始化代码
    }
    
    public func showLogin() {
       let vc =  UIViewController.topMostViewController()
        if vc is FCLoginViewController { // 防止多次弹出
            return
        }
        else {
            let login = FCLoginViewController.build()
            vc.navigationController?.present(login, animated: true)
            
        }
    }
    
    
}
