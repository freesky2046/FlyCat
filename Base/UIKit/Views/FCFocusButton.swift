//
//  FCFocusButton.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/17.
//

import UIKit

protocol FCFocusButtonDelegate: NSObjectProtocol {
    func focuse()
}
 
class FCFocusButton: UIButton {
    
    weak var delegate:FCFocusButtonDelegate?
    var focusBackgroundColor: UIColor?
    var normalBackgroundColor:UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        focusBackgroundColor = UIColor.yellow
        normalBackgroundColor = UIColor.clear
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
