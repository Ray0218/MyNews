//
//  VideoTableViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/4.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import BMPlayer
import NVActivityIndicatorView
import SnapKit
import SVProgressHUD
import RxSwift


class VideoTableViewController: HomeTableViewController {

    private lazy var disposeBag = DisposeBag()

    /// 上一次播放的 cell
    private var priorCell: VideoCell?
    /// 当前播放的时间
    private var currentTime: TimeInterval = 0
    /// 视频真实地址
    private var realVideo = RealVideo()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self

       tableView.rowHeight = kScreenWidth * 0.7
        tableView.k_registerCell(cell: VideoCell.self)
    }

    
}

extension VideoTableViewController {
    
    /// 把播放器添加到 cell 上
    private func addPlayer(on cell: VideoCell) {
        // 视频播放时隐藏 cell 的部分子视图
        cell.hideSubviews()
        // 解析头条的视频真实播放地址
        NetWorkTool.parseVideoRealURL(video_id: cell.video.video_detail_info.video_id, completionHandler: {
            self.realVideo = $0
            cell.rBgIjmageButton.addSubview(self.player)
            self.player.snp.makeConstraints({ $0.edges.equalTo(cell.rBgIjmageButton) })
            // 设置视频播放地址
            self.player.setVideo(resource: BMPlayerResource(url: URL(string: $0.video_list.video_1.mainURL)!))
            self.priorCell = cell
        })
    }
    
    /// 移除播放器
    private func removePlayer() {
        player.pause()
        player.removeFromSuperview()
        priorCell = nil
    }
}



// MARK: - Table view data source
extension VideoTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequenueReusableCell(indexPath: indexPath) as VideoCell
        cell.video = news[indexPath.row]
        // 用户头像
//        cell.avatarButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                let userDetailVC = UserDetailViewController2()
//                userDetailVC.userId = cell.video.user_info.user_id
//                self!.navigationController?.pushViewController(userDetailVC, animated: true)
//            })
//            .disposed(by: disposeBag)
//        // 评论按钮点击
//        cell.commentButton.rx.tap
//            .subscribe(onNext: {
//
//            })
//            .disposed(by: disposeBag)
        // 背景图片按钮点击
        cell.rBgIjmageButton.rx.tap
            .subscribe(onNext: { [weak self] in
                // 如果有值，说明当前有正在播放的视频
                if let priorCell = self!.priorCell {
                    if cell != priorCell {
                        // 设置当前 cell 的属性
                        priorCell.showSubviews()
                        // 判断当前播放器是否正在播放
                        if self!.player.isPlaying {
                            self!.player.pause()
                            self!.player.removeFromSuperview()
                        }
                        // 把播放器添加到 cell 上
                        self!.addPlayer(on: cell)
                    }
                } else { // 说明是第一次点击 cell，直接添加播放器
                    // 把播放器添加到 cell 上
                    self!.addPlayer(on: cell)
                }
            })
            .disposed(by: disposeBag)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 当前点击的 cell
        let currentCell = tableView.cellForRow(at: indexPath) as! VideoCell
        // 如果播放器正在播放，则停止播放
        if player.isPlaying { removePlayer() }
        // 跳转到详情控制器
//        let videoDetailVC = VideoDetailViewController()
//        videoDetailVC.video = currentCell.video
//        videoDetailVC.delegate = self
//        videoDetailVC.currentTime = currentTime
//        videoDetailVC.currentIndexPath = indexPath
//        navigationController?.pushViewController(videoDetailVC, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 找到 VideoViewController
        for viewController in navigationController!.viewControllers {
            if viewController is VideoViewController {
                // 说明有视频正在播放
                if player.isPlaying {
                    let imageButton = player.superview
                    let contentView = imageButton?.superview
                    let cell = contentView?.superview as! VideoCell
                    let rect = tableView.convert(cell.frame, to: viewController.view)
                    // 判断是否滑出屏幕
                    if (rect.origin.y <= -cell.height) || (rect.origin.y >= kScreenHeigh - tabBarController!.tabBar.height) {
                        removePlayer()
                        // 设置当前 cell 的属性
                        cell.showSubviews()
                    }
                }
            }
        }
    }
}
extension VideoTableViewController: BMPlayerDelegate {
    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        self.currentTime = currentTime
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
}
