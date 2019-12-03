//
//  VideoCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/4.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher
import IBAnimatable

class VideoCell: UITableViewCell,RegisterCellOrNib {

    @IBOutlet weak var rTitleLabel: UILabel!
    
    @IBOutlet weak var rBgIjmageButton: UIButton!
    
    @IBOutlet weak var rNameLabel: UILabel!
    @IBOutlet weak var rAvatarButton: AnimatableImageView!
    
    @IBOutlet weak var rCommentButton: UIButton!
    
    
    var video = NewsModel() {
        didSet {
            rTitleLabel.text = video.title
            
            rAvatarButton.kf.setImage(with: URL(string: video.user_info.avatar_url))
             rBgIjmageButton.kf.setBackgroundImage(with: URL(string: video.video_detail_info.detail_video_large_image.urlString), for: .normal)
            rCommentButton.setTitle(video.commentCount, for: .normal)
            rNameLabel.text = video.user_info.name

        }
    }
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension VideoCell {
    /// 视频播放时隐藏 cell 的部分子视图
    func hideSubviews() {
        rTitleLabel.isHidden = true
        rAvatarButton.isHidden = true
//        rNameLabel.isHidden = true
     }
    
    /// 设置当前 cell 的属性
    func showSubviews() {
        rTitleLabel.isHidden = false
        rAvatarButton.isHidden = false
//        rNameLabel.isHidden = false
     }
}
