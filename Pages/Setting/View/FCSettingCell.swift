//
//  FCSettingCell.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/16.
//

import UIKit
import Kingfisher

class FCSettingCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        leftImageView.layer.cornerRadius = 24
        
        leftImageView.layer.masksToBounds = true
        showNormal()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func update(_ item:FCSettingItem) {
        self.leftImageView.isHidden = !item.isImage
        leftLabel.text = item.name
        if(item.isImage) {
            imageView?.kf.setImage(with: URL(string: item.imageUrl!))
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if isFocused {
            showFocus()
        }else {
            showNormal()
        }
    }
    
    func showFocus() {
        contentView.backgroundColor = UIColor(hex: 0xfdfdfd)
        leftLabel.textColor = .black
    }
    
    func showNormal() {
        contentView.backgroundColor = UIColor(hex: 0x37393D)
        leftLabel.textColor = .white
    }

}
