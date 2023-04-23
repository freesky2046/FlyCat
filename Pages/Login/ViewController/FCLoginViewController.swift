//
//  FCLoginViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/22.
//

import UIKit
import CoreImage


class FCLoginViewController: UIViewController {
    
    @IBOutlet weak var qrImageView: UIImageView!
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        qrImageView.image = FCQRBuilder.generateQRCode(from: "www.baidu.com")
    }
    
    static func build() -> FCLoginViewController? {
        let vc = FCLoginViewController(nibName: "FCLoginViewController", bundle: nil);
        return vc
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        refreshQRCode()
    }
    
    func refreshQRCode() -> Void {
        timer?.invalidate()
    }
    

}
