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
 
    public let parent_path:String = "/"
    private var dataArray:[FCVideoListInfo]?
    @IBOutlet weak private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName:"FCVideoItemCell", bundle: nil), forCellWithReuseIdentifier:"FCVideoItemCell");
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
                        self?.dataArray = videoRes?.list
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
    
    static func build() -> FCFileListViewController? {
        let vc = FCFileListViewController(nibName: "FCFileListViewController", bundle: nil);
        return vc
    }
    
    // MARK: - collectionView Delegate collectionView dataSource collectionView flowlayout
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FCVideoItemCell", for: indexPath) as! FCVideoItemCell
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
        let count = 5.0;
        let width:CGFloat = (FCConstant.screenWidth - 60.0 * (count - 1.0)) / count
        return CGSizeMake(width, width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
}
