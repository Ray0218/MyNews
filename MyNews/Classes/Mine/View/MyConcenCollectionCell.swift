//
//  MyConcenCollectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/23.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcenCollectionCell: UICollectionViewCell,RegisterCellOrNib {

    @IBOutlet weak var rTitleLabel: UILabel!
    @IBOutlet weak var rImageView: UIImageView!
        @IBOutlet weak var rVipImage: UIImageView!
    @IBOutlet weak var rTipsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    var myConcernModel : MyConcernModel? {
        didSet {
            rImageView.kf.setImage(with: URL(string: (myConcernModel?.icon)!))
            rTitleLabel.text = myConcernModel?.name
             if let isVertify = myConcernModel?.is_verify {
                rVipImage.isHidden = !isVertify
            }
            
            if let tips = myConcernModel?.tips {
                rTipsButton.isHidden = !tips
            }
         }
    }
    
}
