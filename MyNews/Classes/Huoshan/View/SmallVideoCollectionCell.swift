//
//  SmallVideoCollectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class SmallVideoCollectionCell: UICollectionViewCell,RegisterCellOrNib {
     @IBOutlet weak var rBackImageView: UIImageView!
          @IBOutlet weak var rAvatarButton: AnimatableButton!
    
     @IBOutlet weak var rTitleLabel: UILabel!
     @IBOutlet weak var rScrollLabel: UILabel!
    
     @IBOutlet weak var rConcernButton: AnimatableButton!
    
     @IBOutlet weak var rNameButton: UIButton!
    var rSmallVideo = NewsModel() {
        didSet {
            rNameButton.setTitle(rSmallVideo.raw_data.user.info.name, for: .normal)
            rAvatarButton.kf.setImage(with: URL(string: rSmallVideo.raw_data.user.info.avatar_url), for: .normal)
            rConcernButton.isSelected = rSmallVideo.raw_data.user.relation.is_following
            
            
            if rSmallVideo.raw_data.large_image_list.count != 0 {
                let largeImage = rSmallVideo.raw_data.large_image_list.first?.urlString
                
                rBackImageView.kf.setImage(with: URL(string: largeImage!))
                
            }else if rSmallVideo.raw_data.first_frame_image_list.count != 0 {

                let largeImage = rSmallVideo.raw_data.first_frame_image_list.first?.urlString
                
                rBackImageView.kf.setImage(with: URL(string: largeImage!))
                
            }
            rTitleLabel.attributedText = rSmallVideo.raw_data.attrbutedText
 
        }
    }
  
 
    @IBAction func pvt_avastar(_ sender: UIButton) {
    }
    
    @IBAction func pvt_name(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        rConcernButton.setTitle("关注", for: .normal)
        rConcernButton.setTitle("已关注", for: .selected)

        
    }

    
   
    
}
