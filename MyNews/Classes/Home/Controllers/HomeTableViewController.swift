//
//  HomeTableViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/4.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

import SVProgressHUD
import BMPlayer

class VideoPlayerCustomView: BMPlayerControlView {
    
    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none
    }
    
}


class HomeTableViewController: UITableViewController {
    /// 播放器
    lazy var player: BMPlayer = BMPlayer(customControllView: VideoPlayerCustomView())
    /// 标题
    var newsTitle = HomeNewsTitle()
    /// 新闻数据
    var news = [NewsModel]()
    /// 刷新时间
    var maxBehotTime: TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        SVProgressHUD.pasteConfiguration()
        tableView.tableFooterView = UIView()
//        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
//        tableView.theme_separatorColor = "colors.separatorViewColor"
    }
    
    /// 设置刷新控件
    func setupRefresh(with category: String = "recommend") {
        // 刷新头部
        let header = RefreshHeader { [weak self] in
            // 获取视频的新闻列表数据
            NetWorkTool.loadApiNewsFeeds(category: category, ttFrom: .pull, {
                if self!.tableView.mj_header.isRefreshing { self!.tableView.mj_header.endRefreshing() }
                self!.player.removeFromSuperview()
                self!.maxBehotTime = $0
                self!.news = $1
                self!.tableView.reloadData()
            })
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
        
        //        NetworkTool.loadApiNewsFeeds(category: category, ttFrom: .pull, {
        //            self.player.removeFromSuperview()
        //            self.maxBehotTime = $0
        //            self.news = $1
        //            self.tableView.reloadData()
        //        })
        // 底部刷新控件
        tableView.mj_footer = REfreshAutoGifFotter(refreshingBlock: { [weak self] in
            // 获取视频的新闻列表数据，加载更多
            NetWorkTool.loadMoreApiNewsFeeds(category: category, ttFrom: .loadMore, maxBehotTime: self!.maxBehotTime, listCount: self!.news.count, {
                if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                self!.tableView.mj_footer.pullingPercent = 0.0
                self!.player.removeFromSuperview()
                if $0.count == 0 {
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦！")
                    return
                }
                self!.news += $0
                self!.tableView.reloadData()
            })
        })
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

