//
//  FCPlayerViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit
import Alamofire
import TVVLCKit


class FCPlayerViewController: UIViewController {
    public var path:String? = "/"
    public var adToken:String? = ""
    private var stage:Int = 1
    var player:VLCMediaPlayer!

    
    static func build() -> FCPlayerViewController {
        let vc = FCPlayerViewController(nibName: "FCPlayerViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.stop()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stage = 1;
        refreshPlayerInfo()
    }
    
    func refreshPlayerInfo(){
        if let path = path {
            let url = FCUrl.getPanFile
            var p:Parameters = [:]
            p["path"] = path
            p["type"] = "M3U8_AUTO_720"
            if(self.stage == 2) {
                p["adToken"] = adToken
            }
            p["method"] = "streaming"
            var headers = HTTPHeaders()
            // 添加请求头信息
            headers.add(name: "Host", value: "pan.baidu.com")
            headers.add(name: "User-Agent", value: FCConstant.userAgent())
            FCNetworkUtil.request(url, parameters: p, headers:headers) {[weak self] res in
                switch res {
                case .success(let data):
                    let playerInfo =  FCPlayerInfo.deserialize(from: data);
                    if self?.stage == 1  && playerInfo != nil {
                        if let errno = playerInfo!.errno {
                            if(errno == 0 || errno == 133) {
                                self?.stage = 2
                                self?.adToken = playerInfo?.adToken;
                                var delayInSeconds = 3.0;
                                if let ltime = playerInfo?.ltime {
                                    delayInSeconds = ltime
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                                    self?.refreshPlayerInfo()
                                }
                                return
                            }
                        }
                    }
                    else if self?.stage == 2 && data.count > 0 {
                        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                            return
                        }
                        let fileUrl = documentsDirectory.appendingPathComponent("name.mp4")
                        if FileManager.default.fileExists(atPath: fileUrl.absoluteString) {
                            do {
                                try FileManager.default.removeItem(at: fileUrl)
                            } catch {
                                return
                            }
                        }
                        do {
                            try data.write(to: fileUrl, atomically: true, encoding: .utf8)
                        } catch {
                            return
                        }
                        self?.play(path: fileUrl)

                        
                    }
                    
                case .failure(let error):
                    print(error)
                    
//                    if self?.stage == 2 && playerInfo != nil {
//                        if let errno = playerInfo!.errno {
//                            if(errno == 31341) {
//                                self?.waiting()
//                                return
//                            }
//                        }
//                    }
                }
            }
        }
    }
    
    func play(path:URL) {
        player = VLCMediaPlayer()
//        let m3u8URL = URL(string: "data:text/plain,\(m3u8Content.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        let media = VLCMedia(url:path)
        player = VLCMediaPlayer()
        player.media = media;
        player.play()
        player.drawable = self.view
    }
    
    func waiting() {
        print("轮询转码")
    }
    
}
