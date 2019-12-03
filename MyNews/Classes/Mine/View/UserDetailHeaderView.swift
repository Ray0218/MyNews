
//
//  UserDetailHeaderView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/27.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class UserDetailHeaderView: UIView,NibLoadable {
    
    @IBOutlet weak var rBackGroundView: UIImageView!
    @IBOutlet weak var rBackGroundViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var rAvatarImageView: AnimatableImageView!
    @IBOutlet weak var rVImageView: UIImageView!
    @IBOutlet weak var rNameLabel: UILabel!
    @IBOutlet weak var rTouTiaoImageView: UIImageView!
    @IBOutlet weak var rSendMailBtn: UIButton!
    @IBOutlet weak var rConcernButton: AnimatableButton!
    
    @IBOutlet weak var rRecommendBtn: UIButton!
    @IBOutlet weak var rRecommendBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var rRecommendBtnHeigh: NSLayoutConstraint!
    @IBOutlet weak var rRecommendBtnTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var rRecommendView: UIView!
    @IBOutlet weak var rRecommendViewHeigh: NSLayoutConstraint!
    //头条认证
    @IBOutlet weak var rVertifyAgencyLabel: UILabel!
    @IBOutlet weak var rVertifyAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var rVertifyAgencyLabelTop: NSLayoutConstraint!
    //认证内容
    @IBOutlet weak var rVitifyContentLabl: UILabel!
    //地区
    @IBOutlet weak var rAreaButton: UIButton!
    @IBOutlet weak var rAreaButtonHeigh: NSLayoutConstraint!
    @IBOutlet weak var rAreaButtonTop: NSLayoutConstraint!
    
    //描述内容
    @IBOutlet weak var rDescriptionLabel: UILabel!
    @IBOutlet weak var rDescriptionLabHeigh: NSLayoutConstraint!
    //展开按钮
    @IBOutlet weak var rUnFoldButton: UIButton!
    @IBOutlet weak var rUnFoldBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var rUnFoldButtonTrailing: NSLayoutConstraint!
    //关注数
    @IBOutlet weak var rFollowingsCountLab: UILabel!
    //粉丝数
    @IBOutlet weak var rFollowersCountLabel: UILabel!
    
    //文章  视频  问答
    @IBOutlet weak var rTopTabView: UIView!
    @IBOutlet weak var rTopTabViewHeigh: NSLayoutConstraint!
    @IBOutlet weak var rSeparatorView: UIView!
    @IBOutlet weak var rScrollerView: UIScrollView!
    
    @IBOutlet weak var rBaseView: UIView!
    
    @IBOutlet weak var rBottomScrollerView: UIScrollView!
    var didSelectUserName:((_ userId: String) -> ())?

    
    var rCurrentDontaiTableView : UITableView?
    
    var rCurrentTopType: TopTabType = .dongtai
    var rCurrentSelectIndex = 0
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rConcernButton.setTitle("关注", for: .normal)
        rConcernButton.setTitle("已关注", for: .selected)
        
        //设置主题颜色
        theme_backgroundColor = "colors.black"
        
    }
    
    
    class  func rHeaderView () -> UserDetailHeaderView {
        
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeaderView
    }
    
    //动态数据数组
    var dongtais = [UserDetailDongtai](){
        
        didSet {
            
            if rBottomScrollerView.subviews.count > 0 {
                let tabView = rBottomScrollerView.subviews[0] as! UITableView
                
                tabView.reloadData()
                self.rCurrentDontaiTableView = tabView ;
            }
            
        }
    }
    
    
    
    
    
    var rUserDetailModel: UserDetailModel? {
        
        didSet {
            rBackGroundView.kf.setImage(with: URL(string: rUserDetailModel!.bg_img_url))
            rAvatarImageView.kf.setImage(with: URL(string: rUserDetailModel!.avatar_url))
            rVImageView.isHighlighted = !rUserDetailModel!.user_verified
            rNameLabel.text = rUserDetailModel?.screen_name
            
            if rUserDetailModel?.verified_agency == ""{
                rVertifyAgencyLabelHeight.constant = 0
                rVertifyAgencyLabelTop.constant = 0
                
            }else {
                rVertifyAgencyLabel.text = rUserDetailModel!.verified_agency + ":"
                rVitifyContentLabl.text = rUserDetailModel?.verified_content
            }
            
            rConcernButton.isSelected = rUserDetailModel!.is_following
            if  rUserDetailModel?.area == "" {
                rAreaButton.isHidden = true ;
                rAreaButtonHeigh.constant = 0
                rAreaButtonTop.constant = 0
            }else{
                rAreaButton.setTitle(rUserDetailModel?.area , for: .normal)
                
            }
            
            rDescriptionLabel.text = rUserDetailModel?.description
            
            if rUserDetailModel!.descriptionHeight > 17 {
                rUnFoldButton.isHidden = false
                rUnFoldBtnWidth.constant = 40
            }
            
            
            rFollowingsCountLab.text = rUserDetailModel?.followingsCount
            rFollowersCountLabel.text = rUserDetailModel?.followersCount
            
            
            if rUserDetailModel!.is_followed {
                rConcernButton.isSelected = true
                rRecommendBtn.isHidden = false
                rRecommendBtnTrailing.constant = 15;
                rRecommendBtnWidth.constant = 28
            }else{
                rConcernButton.isSelected = false
                rRecommendBtn.isHidden = true
                rRecommendBtnTrailing.constant = 10;
                rRecommendBtnWidth.constant = 0
            }
            
            
            if (rUserDetailModel?.top_tab.count)! > 0 {
                
                for (index,topTab) in (rUserDetailModel?.top_tab.enumerated())!{
                    let button = UIButton(frame: CGRect(x: CGFloat(index) * kTopTaButtonWidth, y: 0, width: kTopTaButtonWidth, height: rScrollerView.height))
                    button.setTitle(topTab.show_name, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.tag = index
                    button.addTarget(self, action: #selector(pvt_topButton), for: .touchUpInside)
                    rScrollerView.addSubview(button)
                    if index == 0{
                        button.isSelected = true
                        rPrivorButton = button
                    }
                    
                    if index == (rUserDetailModel?.top_tab.count)! - 1 {
                        rScrollerView.contentSize = CGSize(width: button.frame.maxX, height: rScrollerView.height)
                    }
                    
                    
                    let tableView = UITableView(frame: CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: rBottomScrollerView.height))
                    tableView.k_registerCell(cell: UserDetailDongTaiCell.self)
                    tableView.delegate = self
                    tableView.dataSource = self
                    tableView.tableFooterView = UIView()
                    tableView.isScrollEnabled = false
                    rBottomScrollerView.addSubview(tableView)
                    
                    rScrollerView.addSubview(rIndicatorView)
                }
                
                
            }else {
                
                rTopTabViewHeigh.constant = 0
                rTopTabView.isHidden = true
            }
            
            
            layoutIfNeeded()
            
        }
    }
    
    //toptopTab 按钮点击事件
    @objc func pvt_topButton(_ sender: UIButton)  {
        
        rPrivorButton?.isSelected = false
        sender.isSelected = !sender.isSelected
        
        rCurrentSelectIndex = sender.tag
        UIView.animate(withDuration: 0.25, animations: {
            self.rIndicatorView.centerX = sender.centerX
            
            self.rBottomScrollerView.contentOffset = CGPoint(x: CGFloat(sender.tag) * kScreenWidth, y: 0)
            
        }) { (_) in
            self.rPrivorButton = sender
        }
        
    }
    //TopTab 上一次点击的按钮
    private weak var rPrivorButton = Button()
    
    //指示条
    lazy var rIndicatorView: UIView = {
        
        let indecView = UIView(frame: CGRect(x: (kTopTaButtonWidth - kTopTabindicatorWidth)*0.5, y:rTopTabView.height - kTopTabindicatorHeigh , width:kTopTabindicatorWidth, height: kTopTabindicatorHeigh))
        indecView.backgroundColor = UIColor.red
        return indecView
    }()
    
    
    //发私信
    @IBAction func pvt_SendMail(_ sender: UIButton) {
        
        
        let storyBoard = UIStoryboard(name: String(describing: MoreLoginController.self), bundle: nil)
        
        let moreLoginVC = storyBoard.instantiateViewController(withIdentifier: String(describing: MoreLoginController.self)) as! MoreLoginController
        moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(kScreenHeigh-(isIphoneX ? 44 : 20))))
        moreLoginVC.modalPosition = .bottomCenter //底部对齐
        
        UIApplication.shared.keyWindow?.rootViewController!.present(moreLoginVC, animated: true, completion: nil)
        
    }
    //推荐
    @IBAction func pvt_recommend(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        rRecommendViewHeigh.constant = sender.isSelected ? 0 : 223
        
        relationRecommendView.rReCommendLabelHeigh.constant = sender.isSelected ? 0: 32
        relationRecommendView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: {
            
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        }) { (_) in
            self.resetLayout()
        }
        
    }
    //关注
    @IBAction func pvt_concern(_ sender: UIButton) {
        
        if sender.isSelected { //已关注,点击则取消关注
            NetWorkTool.loadRelationUnfollow(user_id: rUserDetailModel!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.rRecommendBtn.isHidden = true
                self.rRecommendBtnHeigh.constant = 0
                self.rRecommendBtnTrailing.constant = 0
                self.rRecommendBtnWidth.constant = 0
                
                self.rRecommendViewHeigh.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    self.rRecommendBtn.imageView?.transform = .identity
                    self.layoutIfNeeded()
                })
            }
            
        }else {//未关注,点击则关注
            NetWorkTool.loadRelationFollow(user_id: rUserDetailModel!.user_id) { (_) in
                sender.isSelected = !sender.isSelected
                self.rRecommendBtn.isHidden = false
                self.rRecommendBtn.isSelected = false
                self.rRecommendBtnHeigh.constant = 28
                self.rRecommendBtnTrailing.constant = 15
                self.rRecommendBtnWidth.constant = 28
                
                self.rRecommendViewHeigh.constant = 233
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                },completion:{ (_) in
                    self.resetLayout()
                    //点击了关注,就会出现推荐数据
                    NetWorkTool.loadRelationUserRecommend(user_id: self.rUserDetailModel!.user_id, completionHandler: { (userCardsArray) in
                        self.rRecommendView.addSubview(self.relationRecommendView)
                        
                        self.relationRecommendView.rUserCardsModel = userCardsArray
                    })
                    
                })
                
                
            }
        }
        
    }
    //展开
    @IBAction func pvt_unfold(_ sender: UIButton) {
        
        rUnFoldButton.isHidden = true
        rUnFoldBtnWidth.constant = 0
        rDescriptionLabHeigh.constant = rUserDetailModel!.descriptionHeight
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            
        }) { (_) in
            
            self.resetLayout()
        }
        
    }
    
    //推荐
    lazy var relationRecommendView: RelationRecommendView = {
        
        let relationView = RelationRecommendView.loadViewFromNib()
        return relationView
    }()
    
    
    fileprivate func resetLayout() {
        
        rBaseView.height = rTopTabView.frame.maxY
        height = rBaseView.frame.maxY
    }
}


extension UserDetailHeaderView : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dongtais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.k_dequenueReusableCell(indexPath: indexPath) as UserDetailDongTaiCell
        
        cell.rUserDongTai = dongtais[indexPath.row]
        cell.didSelectUserName = { (uid) in
            
            self.didSelectUserName!(uid)
        }
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        //        print(offsetY)
        
        if offsetY < 0 {
            
            for subTableView in rBottomScrollerView.subviews {
                let tableView = subTableView as! UITableView
                tableView.isScrollEnabled = false
            }
        }
        
    }
    
    /// 设置 cell 的高度
    private func cellHeight(with dongtai: UserDetailDongtai) -> CGFloat {
        return dongtai.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return cellHeight(with: dongtais[indexPath.row])
        
        
//                switch currentTopTabType {
//                case .dongtai:   // 动态
//                    return cellHeight(with: dongtais[indexPath.row])
//                case .article:   // 文章
//                    return cellHeight(with: articles[indexPath.row])
//                case .video:     // 视频
//                    return cellHeight(with: videos[indexPath.row])
//                case .wenda:     // 问答
//                    let wenda = wendas[indexPath.row]
//                    return wenda.cellHeight
//                case .iesVideo:  // 小视频
//                    return cellHeight(with: iesVideos[indexPath.row])
//                }
    }
    
    
}
