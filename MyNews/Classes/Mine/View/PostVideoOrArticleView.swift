//
//  PostVideoOrArticleView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/29.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class PostVideoOrArticleView: UIView,NibLoadable {
    @IBOutlet weak var rTitleLabel: UILabel!
    
    @IBOutlet weak var rIconImage: UIButton!
   
    @IBOutlet weak var rIconImageWidth: NSLayoutConstraint!
    
    var group = DongtaiOriginGroup() {
        didSet {
            rTitleLabel.text = " " + group.title
            if group.thumb_url != "" {
                rIconImage.kf.setBackgroundImage(with: URL(string: group.thumb_url)!, for: .normal)
            } else if group.user.avatar_url != "" {
                rIconImage.kf.setBackgroundImage(with: URL(string: group.user.avatar_url)!, for: .normal)
            } else if group.delete {
                originContentHasDeleted()
            }
            switch group.media_type {
            case .postArticle:
                rIconImage.setImage(nil, for: .normal)
            case .postVideo:
//                rIconImage.theme_setImage("images.smallvideo_all_32x32_", forState: .normal)
                rIconImage.setImage(UIImage(named: "smallvideo_all_32x32_"), for: .normal)
            }
        }
    }
    
    
    var originGgroup = DongtaiOriginGroup() {
        didSet {
            rTitleLabel.text = " " + originGgroup.title
            if originGgroup.thumb_url != "" {
                rIconImage.kf.setBackgroundImage(with: URL(string: originGgroup.thumb_url)!, for: .normal)
            } else if originGgroup.user.avatar_url != "" {
                rIconImage.kf.setBackgroundImage(with: URL(string: originGgroup.user.avatar_url)!, for: .normal)
            } else if originGgroup.delete {
                originContentHasDeleted()
            }
            switch originGgroup.media_type {
            case .postArticle:
                rIconImage.setImage(nil, for: .normal)
            case .postVideo:
                //                rIconImage.theme_setImage("images.smallvideo_all_32x32_", forState: .normal)
                rIconImage.setImage(UIImage(named: "smallvideo_all_32x32_"), for: .normal)
            }
        }
    }
    
    
    /// 原内容已经删除
    func originContentHasDeleted() {
        rTitleLabel.text = "原内容已经删除"
        rTitleLabel.textAlignment = .center
        rIconImageWidth.constant = 0
        layoutIfNeeded()
    }
    
    
    /// 原内容是否已经删除
    var delete = false {
        didSet {
            originContentHasDeleted()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        width = kScreenWidth - 30
    }

}
