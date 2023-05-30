//
//  FCURLViewController.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/30.
//

import UIKit

class FCURLViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        #if DEBUG
        textField.text = "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"
        #endif
    }
    

    // MARK: - builder
    static func build() -> FCURLViewController? {
        let vc = FCURLViewController(nibName: "FCURLViewController", bundle: nil);
        return vc
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        if(textField.text?.count == 0) {
            let alertController = UIAlertController(title: "请输入m3u8链接", message:"", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default) { _ in
            }
            alertController.addAction(confirmAction)
            present(alertController, animated: true, completion: nil)
        }else {
            let urlPlayVC = FCURLPlayViewController.build()
            urlPlayVC?.m3u8url = textField.text
            self.navigationController?.pushViewController(urlPlayVC!, animated: true)
        }
    }
}
