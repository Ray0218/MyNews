//
//  PopoverAnimator.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
  
    //展现视图大小
    var presentFrame: CGRect?
    //是否已经打开
    var rIsPresent: Bool = false
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
         let rPc =  MyPresentationController(presentedViewController: presented, presenting: presenting)
        rPc.presentFrame = presentFrame
        return rPc
    }
    
    //只要实现这个方法,系统默认动画就消失,所有动画需要我们自己设置
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        rIsPresent = true
        return self
    }
    
    //告诉系统谁来负责 Modal的消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        rIsPresent = false
        return self

    }
    //动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.25
    }
    
    //展开/关闭
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if rIsPresent {
            //拿到需要展现的视图
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitionContext.containerView.addSubview(toView!)
            
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                toView?.transform = .identity
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
            
        }else{
            //拿到需要关闭的视图
            let rfromView = transitionContext.view(forKey: .from)
 
            //执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                
                rfromView?.transform = CGAffineTransform(scaleX: 0, y: 0)
             }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    

}
