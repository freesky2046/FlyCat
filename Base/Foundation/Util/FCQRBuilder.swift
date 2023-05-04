//
//  FCQRBuilder.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/22.
//

import UIKit

class FCQRBuilder: NSObject {
    
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return nil
        }
        return UIImage(ciImage: output)
    }
}
