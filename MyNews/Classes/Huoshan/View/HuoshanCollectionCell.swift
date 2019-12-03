//
//  HuoshanCollectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher

class HuoshanCollectionCell: UICollectionViewCell,RegisterCellOrNib {
    
    @IBOutlet weak var rImageView: UIImageView!
    
    @IBOutlet weak var rPlayCountButton: UIButton!
    
     @IBOutlet weak var rTitleLabel: UILabel!
    
    @IBOutlet weak var rDiggCountLabel: UILabel!
    
    @IBAction func pvt_close(_ sender: UIButton) {
    }
    
    var smallVideo = NewsModel(){
        didSet {
            rTitleLabel.attributedText = smallVideo.raw_data.attrbutedText
            if smallVideo.raw_data.large_image_list.count != 0 {
                
                let  largetImage = smallVideo.raw_data.large_image_list[0]
                
                rImageView.kf.setImage(with: URL(string: largetImage.url as String))
            }else if smallVideo.raw_data.first_frame_image_list.count != 0 {
                let  firstImage = smallVideo.raw_data.first_frame_image_list[0]
                
                rImageView.kf.setImage(with: URL(string: firstImage.url as String))
            }
            
            rDiggCountLabel.text = smallVideo.raw_data.action.diggCount + "赞"
            rPlayCountButton.setTitle(smallVideo.raw_data.action.playCount + "次播放", for: .normal)
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
