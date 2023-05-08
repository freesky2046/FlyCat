//
//  FCVideoItemCell.swift
//  FlyCat
//
//  Created by 周明 on 2023/5/5.
//

import UIKit
import Kingfisher

class FCVideoItemCell: UICollectionViewCell {
    
    enum FCVideoItemStyle {
        case folder
        case video

    }
    
    public var type:FCVideoItemStyle = .folder
    @IBOutlet weak var folderContainer: UIView!
    @IBOutlet weak var folderImageView: UIImageView!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func refresh(data:FCVideoListInfo) {
        if let isdir = data.isdir {
            if isdir == 1 {
                type = .folder
                _showFolder()
            }
            else if data.category == 1{
                _showVideo()
            }
        }
        
        func _showFolder(){
            folderContainer.isHidden = false
            videoContainer.isHidden = true
            folderImageView.image = UIImage(named: "")
        }
        
        func _showVideo() {
            folderContainer.isHidden = true
            videoContainer.isHidden = false
            if let urlStr =  data.thumbs?.url3 {
                let url = URL(string: urlStr)
                videoImageView.kf.setImage(with: url)
            }
            
        }
    }
    
    private func refreshVideoStyle() {
        
    }
    
    private func refreshFolderStyle() {
        
    }

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if(context.nextFocusedView == self) {
            coordinator.addCoordinatedAnimations {
                self.layer.shadowColor = UIColor.white.cgColor;
                self.layer.shadowOffset = CGSizeMake(0, 0);
                self.layer.shadowOpacity = 0.8;
                self.layer.shadowRadius = 20;
                self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            }
        }
        else if(context.previouslyFocusedView == self) {
            coordinator.addCoordinatedAnimations {
                self.layer.shadowColor =  UIColor.clear.cgColor;
                self.layer.shadowOffset = CGSizeMake(0, 0);
                self.layer.shadowOpacity = 0;
                self.layer.shadowRadius = 0;
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
        }
    }

}