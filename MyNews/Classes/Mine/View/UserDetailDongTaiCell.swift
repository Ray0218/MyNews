//
//  UserDetailDongTaiCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher


class UserDetailDongTaiCell: UITableViewCell,RegisterCellOrNib {
    
    @IBOutlet weak var rAvatarImageView: UIImageView!
    @IBOutlet weak var rNameLabel: UILabel!
    @IBOutlet weak var rModifyTimeLabel: UILabel!
    
    @IBOutlet weak var rLikeButton: UIButton!
    @IBOutlet weak var rCommentButton: UIButton!
    @IBOutlet weak var rForwardButton: UIButton!
    @IBOutlet weak var rBottomLabel: UILabel!
    @IBOutlet weak var rContentLabel: RichLabel!
    @IBOutlet weak var rContentLabelHeigh: NSLayoutConstraint!
    @IBOutlet weak var rAllContentLabel: UILabel!
    
    @IBOutlet weak var rMiddelView: UIView!
    
    var didSelectUserName:((_ userId: String) -> ())?
    
    
    //懒加载 发布视频或者文章
    lazy  var postOrarticleView: PostVideoOrArticleView = {
        let postView = PostVideoOrArticleView.loadViewFromNib()
        return postView
        
    }()
    
    
    //懒加载 评论或引用
    lazy  var originThreadView: DongTailOriginThreadView = {
        let postView = DongTailOriginThreadView.loadViewFromNib()
        return postView
        
    }()
    
    
    //    private lazy var rCollectionView: UICollectionView = {
    //        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: DongTaiCollectionViewLayout())
    //        collectionView.k_registerCell(cell: DongTaiCollectionCell.self)
    //        collectionView.delegate = self
    //        collectionView.dataSource = self
    //        collectionView.showsVerticalScrollIndicator = false
    //        collectionView.showsHorizontalScrollIndicator = false
    //        collectionView.isScrollEnabled = false
    //
    //        return collectionView
    //
    //
    //
    //    }()
    //
    
    
    private lazy var rCollectionView: DongTaiCollectionView = {
        let collectionView = DongTaiCollectionView.loadViewFromNib()
        
        return collectionView
        
    }()
    
    
    
    var rUserDongTai: UserDetailDongtai? {
        
        didSet {
            rAvatarImageView.kf.setImage(with: URL(string: (rUserDongTai?.user.avatar_url)!))
            rNameLabel.text = rUserDongTai?.user.screen_name
            rModifyTimeLabel.text =  rUserDongTai?.createTime
            
            rLikeButton.setTitle(rUserDongTai?.diggCount, for: .normal)
            rCommentButton.setTitle(rUserDongTai?.commentCount, for: .normal)
            rForwardButton.setTitle(rUserDongTai?.forwardCount, for: .normal)
            rBottomLabel.text = rUserDongTai!.readCount + "阅读"
            rContentLabel.attributedText =  rUserDongTai?.attributedContent
            rContentLabelHeigh.constant = rUserDongTai!.contentH
            rAllContentLabel.isHidden = rUserDongTai?.contentH == 110 ? false : true
            
            rContentLabel.userTapped = {[weak self](username,range
                ) in
                
                for richContent in (self!.rUserDongTai?.userContents)! {
                    if richContent.name == username{
                        self?.didSelectUserName!(richContent.uid)
                    }
                }
            }
            
            //防止cell的重用机制 导致数据错乱
            if rMiddelView.contains(postOrarticleView) {
                postOrarticleView.removeFromSuperview()
                
            }
            
            if rMiddelView.contains(rCollectionView) {
                rCollectionView.removeFromSuperview()
                
            }
            if rMiddelView.contains(originThreadView) {
                originThreadView.removeFromSuperview()
                
            }
            
            switch rUserDongTai!.item_type {
            case .postVideoOrArticle: //发布了文章或者视频
                
                rMiddelView.addSubview(postOrarticleView)
                postOrarticleView.frame = CGRect(x: 15, y: 0, width: kScreenWidth - 30, height: rMiddelView.height)
                if rUserDongTai?.group.title == ""{
                    postOrarticleView.group = rUserDongTai!.origin_group
                }else {
                    postOrarticleView.group = rUserDongTai!.group
                    
                }
                
                break
            case .postContent,.postSmallVideo: //发布了文字内容
                
                rMiddelView.addSubview(rCollectionView)
                //                rCollectionView.frame = CGRect(x: 15, y: 0, width: rUserDongTai!.collectionViewW, height: rUserDongTai!.collectionViewH)
                
                rCollectionView.frame = CGRect(x: 15, y: 0, width: kScreenWidth - 30, height: rUserDongTai!.collectionViewH)
                
                rCollectionView.thumbImageList = rUserDongTai!.thumb_image_list
                rCollectionView.largeImageList = rUserDongTai!.large_image_list
                if rUserDongTai!.item_type == .postSmallVideo{
                    rCollectionView.isPostSmallVideo = true
                }
                break
                
            case .commentOrQuoteContent://引用 或评论
                
                rMiddelView.addSubview(originThreadView)
                originThreadView.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: (rUserDongTai?.origin_thread.height)!)
                originThreadView.originThread = rUserDongTai!.origin_thread
                break
            default:
                break
            }
            
            
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



//extension UserDetailDongTaiCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return  (rUserDongTai?.thumb_image_list.count)!
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as DongTaiCollectionCell
//
//        cell.thumbImage = rUserDongTai?.thumb_image_list[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return Calculate.collectionViewCellSize((rUserDongTai?.thumb_image_list.count)!)
//    }
//
//}
//
//
