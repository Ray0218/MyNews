//
//  HuoshanNavigationBar.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import SGPagingView

class HuoshanNavigationBar: UIView {
//点击了
    var pageTitleViewDidSelected:((_ index:Int) -> ())?
    
     var pageTitleView: SGPageTitleView?
    
     var titleNames = [String](){
        
        didSet {

            pageTitleView = SGPageTitleView(frame:  CGRect(x: -10, y: 0, width: kScreenWidth, height: 44), delegate: self , titleNames: titleNames, configure: SGPageTitleViewConfigure())
            pageTitleView?.backgroundColor = .clear
            addSubview(pageTitleView!)
            
        }
    }
    
  
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    

}

extension HuoshanNavigationBar: SGPageTitleViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        
        pageTitleViewDidSelected!(selectedIndex)
    }
    
    
}
