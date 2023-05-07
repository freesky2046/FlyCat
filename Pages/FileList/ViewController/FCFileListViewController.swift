//
//  FCFileListViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/3.
//

import UIKit
import Alamofire
import HandyJSON

class FCFileListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    public var parent_path:String = "/"
    public var parent_name:String = "文件列表"
    private var dataArray:[FCVideoListInfo]?
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - builder

    static func build() -> FCFileListViewController? {
        let vc = FCFileListViewController(nibName: "FCFileListViewController", bundle: nil);
        return vc
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName:"FCVideoItemCell", bundle: nil), forCellWithReuseIdentifier:"FCVideoItemCell");
        collectionView.register(UINib(nibName: "FCVideoCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FCVideoCollectionViewHeader")
        collectionView.delegate = self;
        collectionView.dataSource = self;
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
    
    // MARK: - request & handle
    func refreshFileList() {
        var p:Parameters = [:];
        p["method"] = "list";
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
                        self?.dataArray = self?.filter(list: videoRes?.list)
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
        self.collectionView.reloadData()
    }
    
    func showError() {
        
    }
    
    func filter(list:[FCVideoListInfo]?) -> [FCVideoListInfo]? {
        var result:[FCVideoListInfo] = []

        if(list == nil) {
            return nil
        }
        else {
            for item in list! {
                if(item.isdir == nil) {
                    continue
                }
                if item.isdir! == 1 {
                    result.append(item)
                }
                
                if(item.category == nil) {
                    continue
                }
                else if item.category == 1 {
                    result.append(item)
                }
            }
            return result
        }
    }
    

    // MARK: - collectionView Delegate collectionView dataSource collectionView flowlayout
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FCVideoItemCell", for: indexPath) as! FCVideoItemCell
        let info:FCVideoListInfo = self.dataArray![indexPath.row]
        cell.refresh(data: info)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if let count = self.dataArray?.count {
            return count
         }else {
             return 0
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(308, 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextList = FCFileListViewController.build()
        let info:FCVideoListInfo = self.dataArray![indexPath.row]
        if info.path != nil {
            nextList?.parent_path = info.path!
        }
        self.navigationController?.pushViewController(nextList!, animated: true)
    }
 
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FCVideoCollectionViewHeader", for: indexPath) as! FCVideoCollectionViewHeader
        // 更新标题
        print(headerView)
        headerView.leftLabel.font = UIFont.systemFont(ofSize: FCConstant.headline, weight: .medium)
        headerView.leftLabel.backgroundColor = UIColor.clear
        headerView.leftLabel.text = parent_name
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
        return CGSize(width: FCConstant.screenWidth - 90 * 2, height: 66)
    }
}
