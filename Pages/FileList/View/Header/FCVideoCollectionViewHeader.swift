//
//  FCVideoCollectionViewHeader.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit

class FCVideoCollectionViewHeader: UICollectionReusableView {
    @IBOutlet weak var leftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftLabel.font = UIFont.systemFont(ofSize: FCConstant.headline, weight: .medium)
        leftLabel.backgroundColor = UIColor.clear
    }
}
