//
//  FCFileListViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/3.
//

import UIKit
import Alamofire

class FCFileListViewController: UIViewController {

    public let parent_path:String = "/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshFileList();
    }
    
    func refreshFileList() {
        var p:Parameters = [:];
        p["method"] = "videolist HTTP/1.1";
        p["parent_path"] = parent_path;
        p["web"] = 1;
        FCNetworkUtil.request("https://pan.baidu.com/rest/2.0/xpan/file", parameters: p) { res in
            switch res {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    static func build() -> FCFileListViewController? {
        let vc = FCFileListViewController(nibName: "FCFileListViewController", bundle: nil);
        return vc
    }
}
