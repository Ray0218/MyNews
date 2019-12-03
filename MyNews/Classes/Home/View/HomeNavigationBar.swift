//
//  HomeNavigationBar.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/30.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNavigationBar: UIView,NibLoadable {
    
    var didSelectAvatarButton: (() -> ())?
    var didSelectSearchButton: (() -> ())?
    
    
    
    @IBOutlet weak var rAvatarButton: AnimatableButton!
    
    @IBOutlet weak var rSearchButton: UIButton!
    
    @IBAction func pvt_avastarClick(_ sender: UIButton) {
        didSelectAvatarButton!()
    }
    
    @IBAction func pvt_searchButton(_ sender: UIButton) {
        didSelectSearchButton!()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rSearchButton.setBackgroundImage(UIImage(named: "search_small_16x16_"), for: [.normal,.selected])
        rSearchButton.contentHorizontalAlignment = .left
        rSearchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        rSearchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        rSearchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        rSearchButton.setTitleColor(UIColor.blue, for: .normal)
        
        rAvatarButton.theme_setImage("images.home_no_login_head", forState: .normal)
        rAvatarButton.theme_setImage("images.home_no_login_head", forState: .selected)
        
        
        NetWorkTool.loadHomeSearchSuggestInfo { (title) in
            
            self.rSearchButton.setTitle(title, for: .normal)
            
        }
        
        
    }
    
    
    override var frame: CGRect{
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44)
        }
    }
    
    /// 控件的固有属性大小
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
 
    }
 
}
