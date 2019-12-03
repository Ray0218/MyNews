//
//  SettingTableViewCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell,RegisterCellOrNib {
    
    
    @IBOutlet weak var rTitleLabel: UILabel!
    
    @IBOutlet weak var rSubTitleLab: UILabel!
    
    @IBOutlet weak var rRightLabel: UILabel!
    @IBOutlet weak var rSetArrow: UIImageView!
    
    @IBOutlet weak var rSwitchView: UISwitch!
    
    @IBOutlet weak var rBottomLine: UIView!
    
    @IBOutlet weak var rSubTitleHeight: NSLayoutConstraint!
    
    var setting: SettingModel? {
        didSet {
            rTitleLabel.text = setting?.title
            rSubTitleLab.text = setting?.subTitle
            rRightLabel.text = setting?.rightTitle
            
            rSetArrow.isHidden = setting!.isHiddenRightArrow
            rSwitchView.isHidden = setting!.isHiddenRightSwitch
            rSubTitleLab.isHidden = setting!.isHiddenSubTitle
            rRightLabel.isHidden = setting!.isHiddenRightTitle
            
            if !setting!.isHiddenSubTitle {
                rSubTitleHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        theme_backgroundColor = "colors.black"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
