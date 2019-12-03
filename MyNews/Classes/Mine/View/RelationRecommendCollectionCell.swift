//
//  RelationRecommendCollectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class RelationRecommendCollectionCell: UICollectionViewCell,RegisterCellOrNib {
    
    @IBOutlet weak var rAvatarImageView: AnimatableImageView!
    @IBOutlet weak var rVImagView: UIImageView!
    @IBOutlet weak var rNameLabel: UILabel!
    @IBOutlet weak var rRecommendResonLabel: UILabel!
    @IBOutlet weak var rConcerButton: AnimatableButton!
    
    @IBOutlet weak var rLoadingImageView: UIImageView!
    
    var rUserCardModel: UserCard? {
        didSet {
            rAvatarImageView.kf.setImage(with: URL(string: (rUserCardModel?.user.info.avatar_url)!)!)
//            rVImagView.isHidden = ((rUserCardModel?.user.info.user_auth_info.auth_info)! == "") ? true : false
            rNameLabel.text = rUserCardModel?.user.info.name
            rRecommendResonLabel.text = rUserCardModel?.recommend_reason
        }
    }
    
    
    
    
    @IBAction func pvt_concern(_ sender: UIButton) {
        
        rLoadingImageView.isHidden = false
        rLoadingImageView.layer.add(animation, forKey: nil)
        
        if sender.isSelected { //已关注,点击则取消关注
            NetWorkTool.loadRelationUnfollow(user_id: (rUserCardModel?.user.info.user_id)!) { (_) in
                sender.isSelected = !sender.isSelected
  self.rLoadingImageView.layer.removeAllAnimations()
                self.rLoadingImageView.isHidden = true

            }
            
        }else {//未关注,点击则关注
            NetWorkTool.loadRelationFollow(user_id: (rUserCardModel?.user.info.user_id)!) { (_) in
                sender.isSelected = !sender.isSelected
                self.rLoadingImageView.layer.removeAllAnimations()
                 self.rLoadingImageView.isHidden = true

            }
        }
        
    }
    
    
    lazy var animation: CABasicAnimation = {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 1.5
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        return animation
        
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rConcerButton.setTitle("关注", for: .normal)
        rConcerButton.setTitle("已关注", for: .selected)

        
    }

}
