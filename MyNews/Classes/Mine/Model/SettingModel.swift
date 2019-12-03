//
//  SettingModel.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import Foundation
import HandyJSON


struct SettingModel: HandyJSON {
    
    var title = ""
    var subTitle = ""
    var rightTitle = ""

    var isHiddenSubTitle : Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenRightArrow: Bool  = false
    var isHiddenRightSwitch: Bool  = false

}
