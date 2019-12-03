//
//  NoLoginHeaderView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/23.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class NoLoginHeaderView: UIView {
    
    @IBOutlet weak var rBgImageView: UIImageView!
    
    @IBOutlet weak var rCellButton: UIButton!
    @IBOutlet weak var rWetChatButton: UIButton!
    @IBOutlet weak var rQQButton: UIButton!
    @IBOutlet weak var rSinaButton: UIButton!
    @IBOutlet weak var rMoreButton: UIButton!
    @IBOutlet weak var rFavoriteButton: UIButton!
    @IBOutlet weak var rHistoryButton: UIButton!
    @IBOutlet weak var rDayNightButton: UIButton!
    
    @IBOutlet weak var rBottomBgView: UIView!
    class func rHeaderView() -> NoLoginHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! NoLoginHeaderView
    }
    @IBAction func pvt_changeTheme(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        MyTheme.switchNight(sender.isSelected)
        
        
        
        
         UserDefaults.standard.set(sender.isSelected, forKey: kIsNight)
        UserDefaults.standard.synchronize()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dayorNightButtonClick"), object: sender.isSelected)


    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
 
//        ThemeManager.setTheme(plistName: "default_themn", path: .mainBundle)
        
        //设置主题图片
        rCellButton.theme_setImage("images.telButton", forState: .normal)
        rWetChatButton.theme_setImage("images.wetchatButton", forState: .normal)
        rQQButton.theme_setImage("images.qqButton", forState: .normal)
        rSinaButton.theme_setImage("images.sinaButton", forState: .normal)
        rFavoriteButton.theme_setImage("images.favorButton", forState: .normal)
        rHistoryButton.theme_setImage("images.historyButton", forState: .normal)
        rDayNightButton.theme_setImage("images.daynightButton", forState: .normal)
        
        rDayNightButton.setTitle("夜间", for: .normal)
        rDayNightButton.setTitle("日间", for: .selected)
        rDayNightButton.isSelected = UserDefaults.standard.bool(forKey: kIsNight)
        
        rMoreButton.theme_setTitleColor("colors.morLoginTextColor", forState: .normal)
        rMoreButton.theme_backgroundColor = "colors.moreLoginBacColor"
        
        rDayNightButton.theme_setTitleColor("colors.threeColor", forState: .normal)
        rFavoriteButton.theme_setTitleColor("colors.threeColor", forState: .normal)
        rHistoryButton.theme_setTitleColor("colors.threeColor", forState: .normal)
        
        rBottomBgView.theme_backgroundColor = "colors.black"
    }
    
    
}
