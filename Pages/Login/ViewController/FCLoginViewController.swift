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
    var timer:Timer?
    var finalTimes = 200
    var times = 0;
    var device_code:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshQRCode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        destroyTimer()
    }
    
    static func build() -> FCLoginViewController {
        let vc = FCLoginViewController(nibName: "FCLoginViewController", bundle: nil);
        return vc
    }
    
    
    func refreshQRCode() {
        var p:Parameters = [:]
        p["response_type"] = "device_code"
        FCNetworkUtil.request(FCUrl.deviceCode, method: .get, parameters: p, needAuth: false, encoding: URLEncoding.default) { [weak self]  response in
            switch response {
            case .success(let result):
                let deviceInfo = FCDeviceCodeInfo.deserialize(from: result)
                if let user_code = deviceInfo?.user_code, let device_code = deviceInfo?.device_code {
                    let qrUrl  = "https://openapi.baidu.com/device?display=mobile&code=" + "\(user_code)"
                    self?.qrImageView.image = FCQRBuilder.generateQRCode(from: qrUrl)
                    self?.device_code = device_code;
                    self?.fetchToken();
                    self?.startTimer()
                }
            case .failure(let error):
               print(error)
            }
        }
    }
    
    func startTimer()  {
        destroyTimer()
        let s:Selector = #selector(FCLoginViewController.fetchToken);
        timer = Timer(timeInterval: 5.0, target: self, selector:s, userInfo: nil, repeats: false);
        RunLoop.main.add(timer!, forMode: .common);
    }
    
    @objc(fetchToken)
    func fetchToken() {
        var p:Parameters = [:]
        p["grant_type"] = "device_token"
        p["code"] = device_code
        p["client_secret"] = "EaxS0aDs6KB12DfawxddULADEAGTBLIc"
        times = times + 1;
        if(times > finalTimes) { // 如果一直轮询不到，那么重新走获取验证码流程
            refreshQRCode()
            return
        }
        FCNetworkUtil.request(FCUrl.getToken, parameters: p, needAuth: false) { [weak self] response in
            switch response {
            case .success(let result):
                let tokenInfo = FCTokenInfo.deserialize(from: result)
                if let err = tokenInfo?.error {
                    print(err)
                    self?.startTimer()
                }
                else if let token = tokenInfo?.access_token {
                    print(token)
                    self?.destroyTimer();
                    let data = DataConverter.convert(model: tokenInfo!) /// model --- jsonstring--->data
                    UserDefaults.standard.set(data, forKey: "fly.cat.token")
                    
                    self?.dismiss(animated: true)
                }
                
            case .failure(let error):
                print(error)
                self?.startTimer()
            }
        }
    }
         
    func destroyTimer() {
        timer?.invalidate()
        timer = nil;
    }
}
