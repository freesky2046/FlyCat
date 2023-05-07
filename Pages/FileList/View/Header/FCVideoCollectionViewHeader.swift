//
//  FCVideoCollectionViewHeader.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/7.
//

import UIKit

class FCVideoCollectionViewHeader: UICollectionReusableView {
    @IBOutlet weak var leftLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print(self)
    }
}
