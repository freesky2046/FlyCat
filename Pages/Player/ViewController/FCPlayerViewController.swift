//
//  FCPlayerViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit
import Alamofire
import TVVLCKit


class FCPlayerViewController: UIViewController, VLCMediaPlayerDelegate {
    public var path:String? = "/"
    public var adToken:String? = ""
    private var stage:Int = 1
    private var controlView:FCPlayControlView?
    private var playerView:UIView?
    var player:VLCMediaPlayer!
    
    static func build() -> FCPlayerViewController {
        let vc = FCPlayerViewController(nibName: "FCPlayerViewController", bundle: nil)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerview = UIView.init(frame: CGRect(x: 0, y: 0, width: FCConstant.screenWidth, height: FCConstant.screenHeight))
        view.addSubview(playerview)
        playerView = playerview
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if(player != nil) {
            self.player.stop()
        }
        
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
            UIViewController.showHUD()
            FCNetworkUtil.request(url, parameters: p, headers:headers) {[weak self] res in
                UIViewController.hideHUD()
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
                        print("执行播放")
                        var fileURL = URL(string: "")
                        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                             fileURL = cacheDirectory.appendingPathComponent("filename.txt")
                            do {
                                try data.write(to: fileURL!, atomically: true, encoding: .utf8)
                            } catch {
                                return
                            }
                        }

                        self?.play(path:fileURL!)
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func play(path:URL) {
        let options = ["--cr-average=30000"]
        let media = VLCMedia(url:path)
        player = VLCMediaPlayer(options: options)
        player.media = media;
        player.play()
        player.delegate = self
        
        player.drawable = playerView
    }
    

    func mediaPlayerStateChanged(_ aNotification: Notification!) {
           if player.state == .playing {
               // 播放中
               print("播放中");
           } else if player.state == .paused {
               // 暂停中
               print("暂停中")
           } else if player.state == .stopped {
               // 停止播放
               print("停止播放")
           }else if player.state == .opening{
               print("开始")
               controlView?.isHidden = false
           }
       }
       
       func mediaPlayerTimeChanged(_ aNotification: Notification!) {
           // 媒体播放时间发生变化时被调用
//           let time = player.time.value
           
           let currentTime = self.player.time.value
//           let totalTime = self.player.media.length.value
           print(currentTime)
//           print(totalTime)

       }
    
}
