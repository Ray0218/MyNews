//
//  UserDetailBottomView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

protocol UserDetailBottomDelegate: class  {
    func bottomViewClick(_ rSelectBtn: UIButton, _ rBottomTabModel: BottomTab)
}



class UserDetailBottomView: UIView {

    weak var delegate: UserDetailBottomDelegate?
    
    var rBottomTabs = [BottomTab](){
        didSet {
            let rButtonWidth = CGFloat(kScreenWidth - CGFloat(rBottomTabs.count)) / CGFloat(rBottomTabs.count)
            
                for (index,bottomTab) in rBottomTabs.enumerated(){
                    let button = UIButton(frame: CGRect(x: CGFloat(index) * (rButtonWidth + 1), y: 0, width: rButtonWidth, height:height))
                    button.tag = index
                    button.setTitle(bottomTab.name, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.addTarget(self, action: #selector(pvt_bottomButton), for: .touchUpInside)
                    addSubview(button)
                    
                    if index < rBottomTabs.count - 1 {
                        
                        let separatorView = UIView(frame: CGRect(x: button.frame.maxX, y: 6, width: 0.5, height: 32))
                        separatorView.backgroundColor = UIColor.red
                        addSubview(separatorView)
                    }
                    
                  }
                
                
         }
    }
    
    @objc func pvt_bottomButton(_ sender: UIButton)  {
        let bottomTab = rBottomTabs[sender.tag]

        delegate?.bottomViewClick(sender, bottomTab)
 
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
