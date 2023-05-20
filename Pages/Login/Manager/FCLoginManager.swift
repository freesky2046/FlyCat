//
//  FCLoginManager.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/5.
//

import Foundation
import UIKit

protocol FCLoginManagerDelegate : AnyObject {
    func didLogin()
}


class FCLoginManager : FCLoginViewControllerDelegate {
    static let sharedInstance = FCLoginManager()
    weak var delegate:FCLoginManagerDelegate?
    
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
            login.delegate = self
            vc.navigationController?.present(login, animated: true)
        }
    }
    
    internal func didLogin() {
        self.delegate?.didLogin()
    }
    
    
}
