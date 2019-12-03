//
//  UIColor+Extension.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0) {
//        self.init(red: r, green: g, blue: b, alpha: alpha)
        
//        @available(iOS 10.0, *)
        self.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha )
 
    }
    
    
    //创建背景色
  class func globalBackColor() -> UIColor {
        return UIColor(r: 56, g: 249, b: 69)
    }
}


extension UIColor {
//    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
//        self.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
//    }
    
    class func globalBackgroundColor() -> UIColor {
        return UIColor.init(r: 248, g: 249, b: 247)
    }
    ///背景红色
    class func globalRedColor() -> UIColor {
        return UIColor.init(r: 230, g: 100, b: 95)
    }
    
    class func grayColor113() -> UIColor {
        return UIColor.init(r: 113, g: 113, b: 113)
    }
    
    class func grayColor132() -> UIColor {
        return UIColor.init(r: 132, g: 132, b: 132)
    }
    
    class func grayColor232() -> UIColor {
        return UIColor.init(r: 232, g: 232, b: 232)
    }
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }
}
