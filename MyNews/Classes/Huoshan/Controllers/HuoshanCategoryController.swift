//
//  HuoshanCategoryController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import SVProgressHUD

class HuoshanCategoryController: UIViewController {
//标题
    var newsTitle = HomeNewsTitle()
    //刷新时间
    var maxBehotTime = 0.0
    //视频数据
    var smallVides = [NewsModel]()
    
    @IBOutlet weak var rCollectionView: UICollectionView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor = .orange
        rCollectionView.collectionViewLayout = HuoshanLayout()
         rCollectionView.k_registerCell(cell: HuoshanCollectionCell.self)
        
        
        setRefresh()
 
    }
    
    
    func setRefresh()  {
        //下拉刷新
        let header = RefreshHeader{ [weak self] in
            NetWorkTool.loadApiNewsFeeds(category: self!.newsTitle.category, ttFrom: .enterAuto) { (maxBehotTime, smallVideos) in
                
                if self!.rCollectionView.mj_header.isRefreshing {
                    self!.rCollectionView.mj_header.endRefreshing()
                }
                self!.smallVides = smallVideos
                self!.maxBehotTime = maxBehotTime
                self!.rCollectionView.reloadData()
             }
        }
        header?.isAutomaticallyChangeAlpha = true
        header?.beginRefreshing()
        self.rCollectionView.mj_header = header
        
        
        //加载更多
        rCollectionView.mj_footer = REfreshAutoGifFotter(refreshingBlock: { [weak self] in
            
            NetWorkTool.loadMoreApiNewsFeeds(category: self!.newsTitle.category, ttFrom: .enterAuto, maxBehotTime: self!.maxBehotTime, listCount: (self?.smallVides.count)!, { (smallVideos) in
                
                if self!.rCollectionView.mj_footer.isRefreshing {
                    self!.rCollectionView.mj_footer.endRefreshing()
                }
                
               self!.rCollectionView.mj_footer.pullingPercent = 0.0
                if smallVideos.count == 0 {
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                    return
                }
                
                self!.smallVides += smallVideos
                 self!.rCollectionView.reloadData()
                
            })
            
        })
       
    }
    
    
    
    

}


extension HuoshanCategoryController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallVides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as HuoshanCollectionCell
        cell.smallVideo = smallVides[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let smallVC = SmallVideoViewController()
        smallVC.smallVides = smallVides
        smallVC.rCurrentIndex = indexPath.row
         self.present(smallVC, animated: true, completion: nil)
    }
    
    
}


class HuoshanLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
 
        itemSize = CGSize(width: kScreenWidth*0.5, height: kScreenWidth*0.5*1.5)
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 10
    }
}
