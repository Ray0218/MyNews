//
//  SmallVideoViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/9/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable
import BMPlayer
import SnapKit
import NVActivityIndicatorView
import RxCocoa

class SmallVideoViewController: UIViewController {
    
    @IBOutlet weak var rBottomViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var rTitleTop: NSLayoutConstraint!
    @IBOutlet weak var rCollectionView: UICollectionView!
    @IBAction func pvt_more(_ sender: UIButton) {
    }
    @IBAction func pvt_close(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

     @IBOutlet weak var rTitleButton: UIButton!
    
    @IBAction func pvt_write(_ sender: UIButton) {
    }
    @IBOutlet weak var rReadCountButton: UIButton!
    
    @IBAction func pvt_share(_ sender: UIButton) {
    }
    @IBOutlet weak var rAgreeButton: UIButton!
    
    //创建播放器哦
    lazy var rPlayer = BMPlayer(customControllView: SmassVideoPlayCustomerView())
    
    
    
    //小视频数组
    var smallVides = [NewsModel]()
     //当前索引
    var rCurrentIndex: Int = 0
    
    var rCurrentVideo: NewsModel?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

setupUI()
        setPlayer()
        
    }
    
    //设置播放器
    func setPlayer ()  {
        
        let smallVied = rCurrentVideo
        if let viedoUrlStr = smallVied?.raw_data.video.play_addr.url_list.first {
          let dataTask =  URLSession.shared.dataTask(with: URL(string: viedoUrlStr)!) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    let cell = self.rCollectionView.cellForItem(at: IndexPath(item: self.rCurrentIndex, section: 0)) as! SmallVideoCollectionCell
                    
                    if self.rPlayer.isPlaying {
                        self.rPlayer.pause()
                    }
                    if cell.rBackImageView.contains(self.rPlayer){
                        self.rPlayer.removeFromSuperview()
                    }
                    
                    self.rPlayer = BMPlayer(customControllView: SmassVideoPlayCustomerView())

                    cell.rBackImageView.addSubview(self.rPlayer)
                    self.rPlayer.snp.makeConstraints({ (make) in
                        make.edges.equalTo(cell.rBackImageView)
                     })
                    
                    let  asset = BMPlayerResource(url: URL(string: response!.url!.absoluteString)!)
                    self.rPlayer.setVideo(resource: asset)
                }
            }
            
            dataTask.resume()
        }
        
    }


    func setupUI()  {
        
        rCollectionView.collectionViewLayout = SmallVideoLayout()
        
        
        
        rCollectionView.register(UINib(nibName: "SmallVideoCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SmallVideoCollectionCell")
        //        rCollectionView.k_registerCell(cell: SmallVideoCollectionCell.self)
        
        rTitleTop.constant = isIphoneX ? 40 : 0
        rBottomViewBottom.constant = isIphoneX ? 34 : 0
        view.layoutIfNeeded()
        
        let smallViewd = smallVides[rCurrentIndex]
        rCurrentVideo = smallViewd
        if smallViewd.raw_data.group_source == .huoshan {
            rTitleButton.setTitle("火山小视频", for: .normal)
            rTitleButton.setImage(UIImage(named: "detail_huoshan_logo_20x25_"), for: .normal)
        }else if smallViewd.raw_data.group_source == .douyin {
            rTitleButton.setTitle("抖音小视频", for: .normal)
            rTitleButton.setImage(UIImage(named: "detail_douyin_logo_20x25_"), for: .normal)
        }
        
        rReadCountButton.setTitle(rCurrentVideo?.raw_data.action.commentCount , for:.normal)
        rAgreeButton.setTitle(rCurrentVideo?.raw_data.action.diggCount , for:.normal)
        
        rCollectionView.scrollToItem(at: IndexPath(item: rCurrentIndex, section: 0), at: .centeredHorizontally, animated: false)
    }

}

extension SmallVideoViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallVides.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as SmallVideoCollectionCell
        
         cell.rSmallVideo = smallVides[indexPath.item]
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        rCurrentIndex = Int (scrollView.contentOffset.x / scrollView.width + 0.5)
        rCurrentVideo = smallVides[rCurrentIndex]
        setPlayer()
    }
   
}



class SmallVideoLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: collectionView!.width , height:collectionView!.height)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
    }
}
