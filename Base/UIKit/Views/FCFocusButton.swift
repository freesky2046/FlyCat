//
//  FCFocusButton.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/17.
//

import UIKit

protocol FCFocusButtonDelegate : AnyObject{
    func focuse()
}
 
class FCFocusButton: UIButton {
    
    weak var delegate:FCFocusButtonDelegate?
    var focusBackgroundColor: UIColor?
    var normalBackgroundColor:UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        focusBackgroundColor = UIColor.black
        normalBackgroundColor = UIColor.clear
        self.setImage(UIImage(named: "setting_focused"), for: .focused)
        self.setImage(UIImage(named: "setting"), for: .normal)
        self.setImage(UIImage(named: "setting"), for: .highlighted)

    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let focusButton = context.nextFocusedItem as? FCFocusButton  {
            focusButton.delegate?.focuse()
            self.backgroundColor = self.focusBackgroundColor
        }else {
            self.backgroundColor = self.normalBackgroundColor
        }
    }

}
