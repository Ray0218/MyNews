//
//  MyTheme.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/24.
//  Copyright © 2019 Ray. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {
    case day = 0
    case night = 1
    
    static var before = MyTheme.day
    static var current = MyTheme.day
    
    //选择主题
    static func switchTo(_ theme : MyTheme){
        
        before = current
        current = theme
        
        switch theme {
        case .day:
             ThemeManager.setTheme(plistName: "default_themn", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_themn", path: .mainBundle)

        }
    }
    
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    
    static func isNight() -> Bool {
        
        return current == .night
    }
    
}


struct MyThemeStyle {
    //设置日间导航栏
    static func setDayNavigationStyle(_ viewController: UIViewController){
        
        viewController.navigationController?.navigationBar.barStyle = .black
        viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"), for: .default)
        
       
        
    }
    //设置夜间导航栏
    static func setNightNavigationStyle(_ viewController: UIViewController){
        
        viewController.navigationController?.navigationBar.barStyle = .default
        viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white_night"), for: .default)
        
     }
}
