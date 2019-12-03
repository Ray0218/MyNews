//
//  PreViewDongtaiLargeImageController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/31.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
import Photos

class PreViewDongtaiLargeImageController: UIViewController {

    @IBOutlet weak var rollectionView: UICollectionView!
    @IBOutlet weak var rIndexLabel: UILabel!
 
    //图片数组
    var  rImages = [LargeImage]()
    //选中第几个
    var rSelectIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        rollectionView.delegate = self
        rollectionView.dataSource = self
        rollectionView.k_registerCell(cell: DongTaiCollectionCell.self)
        rIndexLabel.text = "\(rSelectIndex + 1)/\(rImages.count)"

        
        
        rollectionView.scrollToItem(at: IndexPath(item: rSelectIndex, section: 0), at: .centeredHorizontally, animated: false)
        view.layoutIfNeeded()
        
     }


 
    // MARK: - 保存

     @IBAction func pvt_save(_ sender: UIButton) {
        
        let largeImage = rImages[rSelectIndex]
        //下载图片
        ImageDownloader.default.downloadImage(with: URL(string: largeImage.urlString)!, options: nil, progressBlock: { (receiveSize, totalSize) in
            
            let progress = Float(receiveSize/totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setForegroundColor(.white)
            
        }) { (image,cacheType,imageUrl,error) in
            
            //保存到系统
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
                
            }, completionHandler: { (success, error) in
                SVProgressHUD.dismiss()
                if success {
                    SVProgressHUD.showSuccess(withStatus: "保存图片成功")
                }
            })
            
        }
     }
 

}



extension PreViewDongtaiLargeImageController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as DongTaiCollectionCell

         cell.largeImage = rImages[indexPath.item]
        cell.rThunmImage.contentMode = .scaleAspectFit
        cell.rThunmImage.layer.borderWidth = 0
        cell.backgroundColor = .black
        return cell
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        dismiss(animated: false, completion: nil)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         rSelectIndex = Int(scrollView.contentOffset.x/rollectionView.width + 0.5)
        rIndexLabel.text = "\(rSelectIndex + 1)/\(rImages.count)"

    }
}
