//
//  FCURLPlayViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/30.
//

import UIKit
import AVFoundation

class FCURLPlayViewController: UIViewController {

    public var m3u8url:String?
    public var player:AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let m3u8url = m3u8url {
            guard let url = URL(string: m3u8url) else {
                let alertController = UIAlertController(title: "m3u8链接格式不正确", message:"", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "请重新输入", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(confirmAction)
                present(alertController, animated: true, completion: nil)
                return
            }
            let playerItem = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = view.bounds
            view.layer.addSublayer(playerLayer)
            playerItem.addObserver(self, forKeyPath:"status", options: .new, context:nil)
            UIViewController.showHUD()


        }
    }
    
    // MARK: - builder
    static func build() -> FCURLPlayViewController? {
        let vc = FCURLPlayViewController(nibName: "FCURLPlayViewController", bundle: nil);
        return vc
    }
    
    deinit {
        player?.pause()

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let value = change?[.newKey] as? Int{
            if value == 1 {
                player?.play()
                UIViewController.hideHUD()
            }
            else if value == 2 {
                UIViewController.hideHUD()
                let alertController = UIAlertController(title: "播放失败，请返回", message:"", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "确定", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(confirmAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
//    - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//        AVPlayerItem *item = (AVPlayerItem *)object;
//        if ([keyPath isEqualToString:@"status"]) {
//             //获取更改后的状态
//            AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
//            if (status == AVPlayerStatusReadyToPlay) {
//                CMTime duration = item.duration; // 获取视频长度
//                // 设置视频时间
////                [self setMaxDuration:CMTimeGetSeconds(duration)];
//                 // 播放
//                [self play];
//            } else if (status == AVPlayerStatusFailed) {
//                NSLog(@"AVPlayerStatusFailed");
//            } else {
//                NSLog(@"AVPlayerStatusUnknown");
//            }
//        } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
////             NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
////             CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
////            [self.loadedProgress setProgress:timeInterval / totalDuration animated:YES]; // 更新缓冲条
//        }
//    }
}
