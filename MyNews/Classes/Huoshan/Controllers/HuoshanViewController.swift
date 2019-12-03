//
//  HuoshanViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/21.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import SGPagingView

class HuoshanViewController: UIViewController {
    
    var newsTitles = [HomeNewsTitle]()
    
    var rPageContentView: SGPageContentScrollView?
    
    
    var rNavBarView: HuoshanNavigationBar = {
        
        let nvaBar = HuoshanNavigationBar()
        return nvaBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    //    var pageContentView: SGPageContentView?
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension HuoshanViewController {
    
    func setupUI( ){
        
        navigationItem.titleView = rNavBarView
        
        if UserDefaults.standard.bool(forKey: kIsNight){
            
            MyThemeStyle.setNightNavigationStyle(self)
            
        }else {
            MyThemeStyle.setDayNavigationStyle(self)
            
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(receviceNotifuceation(notifucation:)), name: NSNotification.Name(rawValue: "dayorNightButtonClick"), object: nil)
        
        NetWorkTool.loadSmallVideoCategories { (newsTitles) in
            self.newsTitles = newsTitles
            
            self.rNavBarView.titleNames = newsTitles.compactMap({
                $0.name
            })
            
            
            
            
            var  childsArr = [HuoshanCategoryController]()
            
            _  =  newsTitles.compactMap({
                
                let  categoryVC = HuoshanCategoryController()
                categoryVC.newsTitle = $0
//                self.addChild(categoryVC)
                childsArr.append(categoryVC)
                
            })
            self.rPageContentView = SGPageContentScrollView(frame: self.view.bounds, parentVC: self, childVCs: childsArr)
//            self.rPageContentView = SGPageContentScrollView(frame: CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: kScreenHeigh - 100), parentVC: self, childVCs: self.children)

            self.rPageContentView?.backgroundColor = .green
            self.rPageContentView?.delegatePageContentScrollView = self
            self.view.addSubview(self.rPageContentView!)
        }
        
        //点击了标题
        rNavBarView.pageTitleViewDidSelected = {[weak self] (index) in
            self?.rPageContentView?.setPageContentScrollViewCurrentIndex(index)
        }
    }
    
    
    
    
    @objc func receviceNotifuceation(notifucation:Notification)  {
        
        if UserDefaults.standard.bool(forKey: kIsNight){
            
            MyThemeStyle.setNightNavigationStyle(self)
            
        }else {
            MyThemeStyle.setDayNavigationStyle(self)
        }
    }
    
    
}


extension HuoshanViewController:SGPageContentScrollViewDelegate {
    
    
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.rNavBarView.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
