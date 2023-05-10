//
//  FCPlayerViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit
import Alamofire
import AVKit

class FCPlayerViewController: UIViewController {
    public var path:String? = "/"
    public var adToken:String? = ""
    private var stage:Int = 1
    private var player:AVPlayer?
    var playerItem: AVPlayerItem?

    
    static func build() -> FCPlayerViewController {
        let vc = FCPlayerViewController(nibName: "FCPlayerViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        do {
                            try data.write(to: fileUrl, atomically: true, encoding: .utf8)
                        } catch {
                            return
                        }
                        self?.playerItem = AVPlayerItem(url: fileUrl)
                        self?.player = AVPlayer(playerItem: self?.playerItem)
                        if(self != nil){
                            self!.player?.addObserver(self!, forKeyPath: "status", options: [.old, .new], context: nil)
                        }
                        let playerLayer = AVPlayerLayer(player: self?.player)
                        playerLayer.backgroundColor = UIColor.red.cgColor
                        playerLayer.frame = self?.view?.bounds ?? CGRect()
                        self?.view.layer.addSublayer(playerLayer)
                        self?.player?.play()
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
    
    func waiting() {
        print("轮询转码")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let player = object as? AVPlayer {
            switch player.status {
            case .unknown:
                // 播放状态未知
                print("unknown")
            case .readyToPlay:
                // 播放器已准备好播放视频
                print("readyToPlay")
            case .failed:
                // 播放失败
                print("error")
            @unknown default:
                break
            }
        }
    }

}
