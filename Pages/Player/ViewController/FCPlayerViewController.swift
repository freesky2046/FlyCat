//
//  FCPlayerViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit
import Alamofire

class FCPlayerViewController: UIViewController {
    public let path:String = "/"
    
    static func build() -> FCPlayerViewController? {
        let vc = FCPlayerViewController(nibName: "FCPlayerViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshPlayerInfo()
    }
    
    func refreshPlayerInfo(){
        let url = FCUrl.getPanFile
        var p:Parameters = [:]
        p["path"] = path
        p["M3U8_AUTO_1080"] = "M3U8_AUTO_1080"
        
        FCNetworkUtil.request(url, parameters: p, headers: [:]) { res in
            print(res)
        }
    }

}
