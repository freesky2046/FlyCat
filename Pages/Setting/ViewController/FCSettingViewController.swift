//
//  FCSettingViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/16.
//

import UIKit
import HandyJSON
import Alamofire
import Kingfisher

class FCSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var dataArray: NSMutableArray?  /// 数据源，要拼装一下给列表使用
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    static func build() -> FCSettingViewController? {
        let vc = FCSettingViewController(nibName: "FCSettingViewController", bundle: nil);
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册XIB cell
        let nib = UINib(nibName: "FCSettingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FCSettingCell")
        tableView.estimatedSectionFooterHeight = 0.0;
        tableView.estimatedSectionHeaderHeight = 0.0;
        if #available(tvOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0;
        }
        tableView.contentInsetAdjustmentBehavior = .never
        leftImageView.layer.cornerRadius = 113
        leftImageView.layer.masksToBounds = true
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshListInfo()
    }
    
    func refreshListInfo() {
        var p:Parameters = [:]
        p["method"] = "uinfo"
        FCNetworkUtil.request("https://pan.baidu.com/rest/2.0/xpan/nas", method: .get, parameters: p, needAuth: true) {[weak self] res in
            guard let self = self else { return }
            
            switch (res) {
            case .success(let data):
                print(data)
                self.handle(data)
            case .failure(let error):
                print(error)
            }
        };
    }
    
    func handle(_ data:String) {
        let res =  FCUserInfo.deserialize(from: data);
        let item = FCSettingItem()
        item.name = res?.baidu_name
//        item.imageUrl = res?.avatar_url
        dataArray?.insert(item, at: 0)
        tableView.reloadData()
    }
    
    
    func setupUI() {
        let item1 = FCSettingItem()
        item1.name = "设置"
        let item2 = FCSettingItem()
        item2.name = "关于"
        dataArray = NSMutableArray()
        let item3 = FCSettingItem()
        item3.name = "退出登录"
        dataArray?.add(item1)
        dataArray?.add(item2)
        dataArray?.add(item3)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "FCSettingCell", for: indexPath) as! FCSettingCell
       let item = self.dataArray?.object(at: indexPath.section) as! FCSettingItem
       cell.update(item)
       return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataArray = self.dataArray, indexPath.row  == dataArray.count - 1 {
            self.showLoginOutAlert()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let dataArray = self.dataArray {
            return dataArray.count
        }else {
            return 0
        }
    }
    
    func showLoginOutAlert() {
        let alert = UIAlertController(title: "退出登录", message:"", preferredStyle: .alert)
    }
}
