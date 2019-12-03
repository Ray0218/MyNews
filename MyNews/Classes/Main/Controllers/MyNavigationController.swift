//
//  MyNavigationController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "colors.navbartintColor"
//        navigationBar.theme_barTintColor = "colors.black"
        
        if UserDefaults.standard.bool(forKey: kIsNight){
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        }else {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)

        }
        
        
        //全局拖拽手势
        initGlobalPan()
        // Do any additional setup after loading the view.
        
        
        
          NotificationCenter.default.addObserver(self, selector: #selector(receviceNotifuceation(notifucation:)), name: NSNotification.Name(rawValue: "dayorNightButtonClick"), object: nil)
        
        
        
    }
    
    @objc func receviceNotifuceation(notifucation:Notification)  {
        
        let isNight = notifucation.object as! Bool
        
        if isNight {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)

        }else {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)

        }
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(pvt_navBack))
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    @objc private func pvt_navBack() {
        popViewController(animated: true)
    }
    
    
}


extension MyNavigationController: UIGestureRecognizerDelegate {
    
    func initGlobalPan() {
        let target = interactivePopGestureRecognizer?.delegate
        let  globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        
        globalPan.delegate = self
        view.addGestureRecognizer(globalPan)
        //禁止系统手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count != 1
    }
    
}
