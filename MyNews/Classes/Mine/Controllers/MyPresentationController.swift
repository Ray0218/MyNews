//
//  MyPresentationController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {
    
    
    var presentFrame: CGRect?
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(pvt_disMiss), name: NSNotification.Name(rawValue: kDismissModalView), object: nil)
        
    }
    
    
    
    //即将布局转场子视图调用
    override func containerViewWillLayoutSubviews() {
        
        presentedView?.frame = presentFrame!
        
        let coverView = UIView(frame: UIScreen.main.bounds)
        coverView.backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pvt_disMiss))
        
        coverView.addGestureRecognizer(tap)
        
        
        //在容器视图上添加一个蒙版
        containerView?.insertSubview(coverView, at: 0)
        
    }
    
    //移除视图
    @objc func pvt_disMiss()  {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
