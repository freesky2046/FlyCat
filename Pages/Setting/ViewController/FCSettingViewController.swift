//
//  FCSettingViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/16.
//

import UIKit

class FCSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var dataArray: NSMutableArray?
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
        setupUI()
    }
    
    func setupUI() {
        let item1 = FCSettingItem()
        item1.name = "关于"
        item1.detail = ""
        item1.showNext = false
        let item2 = FCSettingItem()
        item2.name = "退出登录"
        item2.detail = ""
        item2.showNext = false
        dataArray = NSMutableArray()
        dataArray?.add(item1)
        dataArray?.add(item2)
        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "FCSettingCell", for: indexPath) as! FCSettingCell
       let item = self.dataArray?.object(at: indexPath.row) as! FCSettingItem
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
}
