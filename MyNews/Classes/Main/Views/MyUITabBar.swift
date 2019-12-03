//
//  MyUITabBar.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyUITabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButton)
        
        
        theme_tintColor = "colors.tabbarColor"
        theme_barTintColor = "colors.black"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  private  lazy  var publishButton : UIButton = {
    
    let publishButton = UIButton(type: .custom)
    
    publishButton.theme_setBackgroundImage("images.publishButton", forState: .normal)
    publishButton.theme_setBackgroundImage("images.publishSelectButton", forState: .selected)

    
//    publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
//    publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
//
    publishButton.sizeToFit()
    return publishButton

    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.width
        let height = frame.height
        
        
        publishButton.center = CGPoint(x: width*0.5, y: height*0.5)
        let buttonW : CGFloat = width*0.2
        let buttonH : CGFloat = height
        let buttonY : CGFloat = 0
        
        var index = 0
        
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){
                continue
            }
            
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
            
        }
        
        
    }
    

}
