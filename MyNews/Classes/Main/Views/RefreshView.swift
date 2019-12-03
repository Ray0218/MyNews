//
//  RefreshView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/2.
//  Copyright © 2019 Ray. All rights reserved.
//

import MJRefresh


class RefreshHeader: MJRefreshGifHeader {
    
    override func prepare() {
        super.prepare()
        mj_h = 50
        var images = [UIImage]()
        
        
        for index in 0 ..< 16 {
            let image = UIImage(named: "dropdown_loading_0\(index)")
            images.append(image!)
        }
        //设置空闲状态图片
        setImages(images, for: .idle)
        //设置刷新状态图片
        setImages(images, for: .refreshing)
        setTitle("下拉推荐", for: .idle)
        setTitle("松开推荐", for: .idle)
        setTitle("推荐中", for: .refreshing)
 
        
    }
    
    
    override func placeSubviews() {
        super.placeSubviews()
        gifView.contentMode = .center
        gifView.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25 )
        stateLabel.font = UIFont.systemFont(ofSize: 12)
        stateLabel.frame = CGRect(x: 0, y: 25, width: mj_w, height: 14)
    }
}



class REfreshAutoGifFotter: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        mj_h = 50
        var images = [UIImage]()
        
        
        for index in 0 ..< 8 {
            let image = UIImage(named: "sendloading_18x18_\(index)")
            images.append(image!)
        }
        //设置空闲状态图片
        setImages(images, for: .idle)
    //设置刷新状态图片
        setImages(images, for: .pulling)
        setTitle("正在努力加载", for: .idle)
        setTitle("正在努力加载", for: .idle)
        setTitle("正在努力加载", for: .idle)
        setTitle("没有更多数据加载啦", for: .noMoreData)

        
    }
    
    
    override func placeSubviews() {
        super.placeSubviews()
        gifView.x = 135
        gifView.centerY = stateLabel.centerY
    }
}
