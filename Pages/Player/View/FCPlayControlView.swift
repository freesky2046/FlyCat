//
//  FCPlayControlView.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/20.
//

import UIKit

class FCPlayControlView: UIView {
    
    private var normalColor:UIColor!
    private var unusedColor:UIColor!
    
    @IBOutlet weak var progessView: UIProgressView!
    @IBOutlet weak var bottomContainerView: UIView!
    static func build()->FCPlayControlView {
        let myView = Bundle.main.loadNibNamed("FCPlayControlView", owner: self, options: nil)?.first as! FCPlayControlView
        return myView
    }
    
    override func awakeFromNib() {
         super.awakeFromNib()
         bottomContainerView.backgroundColor = UIColor.clear
    }
}
