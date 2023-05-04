//
//  FCFileListViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/3.
//

import UIKit
import Alamofire
import HandyJSON

class FCFileListViewController: UIViewController {

    public let parent_path:String = "/"
    private var dataArray:[FCVideoListInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let token = FCNetworkUtil.userToken();
        if(token?.access_token == nil){
            let login:FCLoginViewController? = FCLoginViewController.build();
            self.present(login!, animated: true)
        }else {
            refreshFileList();
        }
    }
    
    func refreshFileList() {
        var p:Parameters = [:];
        p["method"] = "videolist";
        p["parent_path"] = parent_path;
        p["web"] = 1;
        FCNetworkUtil.request("https://pan.baidu.com/rest/2.0/xpan/file", parameters: p) {[weak self] res in
            switch res {
            case .success(let data):
                let videoRes =  FCVideoListInfoRes.deserialize(from: data);
                if let  errorno = videoRes?.errno  {
                    if errorno != 0 {
                        self?.showError()
                    }else {
                        self?.dataArray = videoRes?.info
                        self?.reloadData()
                    }
                }else {
                    self?.showError()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func reloadData() {
        
    }
    
    func showError() {
        
    }
    
    static func build() -> FCFileListViewController? {
        let vc = FCFileListViewController(nibName: "FCFileListViewController", bundle: nil);
        return vc
    }
}
