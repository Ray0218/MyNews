//
//  VideoViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/21.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import SGPagingView


class VideoViewController: UIViewController {
    
    /// 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentScrollView?
    
    
    lazy var rNavigationBar: HomeNavigationBar = {
        
        let navBar = HomeNavigationBar.loadViewFromNib()
        return navBar
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
 
        
    }
}


extension VideoViewController {
    
    func setUpUI ()  {
        
        view.backgroundColor = UIColor(red: 29/255.0, green: 95/255.0, blue: 66/255.0, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = rNavigationBar
        
        
        //点击头像按钮
        rNavigationBar.didSelectAvatarButton = { [weak self] in
            
            self?.navigationController?.pushViewController(MineViewController(), animated: true)
            
        }
        
        rNavigationBar.didSelectSearchButton = {
            
        }
        
 
        
        // 视频顶部新闻标题的数据
        NetWorkTool.loadVideoApiCategoies {
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = .globalRedColor()
            configuration.indicatorColor = .clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: newsTitleHeight), delegate: self, titleNames: $0.compactMap({ $0.name }), configure: configuration)
            self.pageTitleView!.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            
            var vcArrs = [VideoTableViewController]()
            // 设置子控制器
            _ = $0.compactMap({ (newsTitle) -> () in
                let videoTableVC = VideoTableViewController()
                videoTableVC.setupRefresh(with: newsTitle.category)
                //                self.addChild(videoTableVC)
                vcArrs.append(videoTableVC)
            })
            // 内容视图
            self.pageContentView = SGPageContentScrollView(frame: CGRect(x: 0, y: newsTitleHeight, width: kScreenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: vcArrs)
            self.pageContentView!.delegatePageContentScrollView = self
            self.view.addSubview(self.pageContentView!)
        }
        
    }
}


// MARK: - SGPageTitleViewDelegate
extension VideoViewController: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    /// 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        
 
        self.pageContentView!.setPageContentScrollViewCurrentIndex(selectedIndex)
        
    }
    
    /// 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
