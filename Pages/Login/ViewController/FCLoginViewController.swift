//
//  FCLoginViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/22.
//

import UIKit
import CoreImage
import Alamofire

class FCLoginViewController: UIViewController {
    
    @IBOutlet weak var qrImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshQRCode()
    }
    
    static func build() -> FCLoginViewController? {
        let vc = FCLoginViewController(nibName: "FCLoginViewController", bundle: nil);
        return vc
    }
    
    
    func refreshQRCode() -> Void {
        var p:Parameters = [:]
        p["response_type"] = "device_code"
        FCNetworkUtil.request(FCUrl.deviceCode, method: .get, parameters: p, needAuth: false, encoding: URLEncoding.default) { response in

        }
    }
    

}
