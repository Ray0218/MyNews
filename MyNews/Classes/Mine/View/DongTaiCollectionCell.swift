//
//  DongTaiCollectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/29.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class DongTaiCollectionCell: UICollectionViewCell,RegisterCellOrNib {

    @IBOutlet weak var rThunmImage: UIImageView!
    
    @IBOutlet weak var rIconButton: UIButton!
    
    var isPostSmallVideo = false {
        didSet {
            rIconButton.setImage(isPostSmallVideo ? UIImage(named: "smallvideo_all_32x32_") : nil, for: .normal)

        }
    }
    
    
    var thumbImage : ThumbImage? {
        didSet {
            self.rThunmImage.kf.setImage(with: URL(string: thumbImage!.urlString))
        }
    }
    
    
    var largeImage : LargeImage? {
        didSet {
//            self.rThunmImage.kf.setImage(with: URL(string: largeImage!.urlString))
            
 
            rThunmImage.kf.setImage(with: URL(string: largeImage!.urlString), placeholder: nil, options: nil, progressBlock: { (receiveSize, totalSize) in
                let progress = Float(receiveSize/totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(.white)
                
            }) { (image,cacheType,imageUrl,error) in
                SVProgressHUD.dismiss()
            }
            
        }
    }
      
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
