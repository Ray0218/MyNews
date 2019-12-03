//
//  DongTaiCollectionView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/29.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class DongTaiCollectionView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,NibLoadable {
    
    var isPostSmallVideo = false
    
    
    
    var thumbImageList = [ThumbImage]() {
         didSet {
            
            reloadData()
        }
    }
    
    var largeImageList = [LargeImage]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        collectionViewLayout = DongTaiCollectionViewLayout()
        
        k_registerCell(cell: DongTaiCollectionCell.self)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        //     isScrollEnabled = false
        backgroundColor = UIColor.purple
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  thumbImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as DongTaiCollectionCell
        cell.isPostSmallVideo = isPostSmallVideo
        cell.thumbImage = thumbImageList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Calculate.collectionViewCellSize(thumbImageList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewLargeVC  = PreViewDongtaiLargeImageController()
        previewLargeVC.rSelectIndex = indexPath.item
        previewLargeVC.rImages = largeImageList
        UIApplication.shared.keyWindow?.rootViewController?.present(previewLargeVC, animated: false, completion: nil)
    }
    
}

class DongTaiCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
        scrollDirection = .horizontal
        
    }
}
