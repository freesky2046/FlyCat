//
//  FCFirstViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/30.
//

import UIKit

class FCFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - builder
    static func build() -> FCFirstViewController? {
        let vc = FCFirstViewController(nibName: "FCFirstViewController", bundle: nil);
        return vc
    }
    

    @IBAction func m3u8Action(_ sender: Any) {
        let urlVC = FCURLViewController.build()
        self.navigationController?.pushViewController(urlVC!, animated: true)
    }
    
    
    @IBAction func baiduAction(_ sender: Any) {
        let homevc = FCHomeViewController.build()
        self.navigationController?.pushViewController(homevc!, animated: true)
    }
}
