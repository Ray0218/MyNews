//
//  MyOtherCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell,RegisterCellOrNib {
    
 var leftLabel: UILabel!
     var rightLabel: UILabel!
  var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
