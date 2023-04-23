//
//  FCHomeViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/22.
//

import UIKit

class FCHomeViewController: UIViewController {
    
    

    @IBOutlet weak var recentlyCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    func setupView() {
        let cellSpacing: CGFloat = 40
        let contentInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
        let cellSize = CGSize(width: 410, height: 250)
       // 创建 UICollectionViewFlowLayout 实例
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = contentInsets
        layout.itemSize = cellSize

        
    }
    

}


extension FCHomeViewController {
    
}
