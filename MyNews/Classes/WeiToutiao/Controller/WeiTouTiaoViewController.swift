//
//  WeiTouTiaoViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/31.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class WeiTouTiaoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
    
    
    
}


extension WeiTouTiaoViewController {
    
    func setupUI( ){
        
        if UserDefaults.standard.bool(forKey: kIsNight){
            
            MyThemeStyle.setNightNavigationStyle(self)
            
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(pvt_rightNavBar))
            
        }else {
            MyThemeStyle.setDayNavigationStyle(self)
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(pvt_rightNavBar))
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(receviceNotifuceation(notifucation:)), name: NSNotification.Name(rawValue: "dayorNightButtonClick"), object: nil)
        
    }
    
    @objc func pvt_rightNavBar() {
        
    }
    
    
    @objc func receviceNotifuceation(notifucation:Notification)  {
        
        if UserDefaults.standard.bool(forKey: kIsNight){
            
            MyThemeStyle.setNightNavigationStyle(self)
            
        }else {
            MyThemeStyle.setDayNavigationStyle(self)
        }
    }
    
    
}
