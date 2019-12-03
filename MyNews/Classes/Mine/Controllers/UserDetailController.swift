//
//  UserDetailController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/27.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class UserDetailController: UIViewController {
    
    //修改状态栏字体颜色
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var rUserId: Int = 0
    
    var rUserModel: UserDetailModel?
    
    
    @IBOutlet weak var rScrollerView: UIScrollView!
    @IBOutlet weak var rBottomView: UIView!
    
    @IBOutlet weak var rBottomViewBottom: NSLayoutConstraint!
    @IBOutlet weak var rBottomHeigh: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        rScrollerView.delegate = self
        
        view.addSubview(rNavigationBar)
        
        //设置约束,避免bottomview订到边界
        rBottomViewBottom.constant = isIphoneX ? 34 : 0
        view.layoutIfNeeded()
        
        
//        rUserId = 51025535398
        //获取用户详情
        NetWorkTool.loadUserDetailData(user_id: rUserId) { (ruserModel) in
            
            NetWorkTool.loadUserDetailDongtaiList(userId: self.rUserId, maxCursor: 0, completionHandler: { (max, userDetailDongTais) in
                
                self.rScrollerView.addSubview(self.rHeaderView)
                
                self.rHeaderView.dongtais = userDetailDongTais
                self.rUserModel = ruserModel
                self.rHeaderView.rUserDetailModel = ruserModel
                self.rNavigationBar.rNameLabel.text = ruserModel.name
                
                if ruserModel.bottom_tab.count == 0 {
                    self.rBottomViewBottom.constant = 0
                    self.rBottomHeigh.constant = 0
                    self.rHeaderView.height = 969 - 44
                    
                    self.rHeaderView.height = self.rHeaderView.rTopTabView.frame.minY + self.rHeaderView.rBaseView.frame.minY - self.rNavigationBar.height + self.rScrollerView.height
                    self.view.layoutIfNeeded()

                }else {
                    self.rHeaderView.height = 969
                    
//                    self.rHeaderView.height = kScreenHeigh - kBottomSafeHeigh  - 44

                    
                    self.rBottomView.addSubview(self.rMyBottomView)
                    self.rMyBottomView.rBottomTabs = ruserModel.bottom_tab
                }
                self.rScrollerView.contentSize = CGSize(width: kScreenWidth, height: self.rHeaderView.height)
                
                

            })
            
            
            
            
        }
        
    }
    
    
    lazy var rNavigationBar : MyNavigationBarView = {
        
        let navBar = MyNavigationBarView.loadViewFromNib()
        
        navBar.goBackButtonClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        return navBar
        
    }()
    
    //懒加载headerview
    lazy var rHeaderView : UserDetailHeaderView = { [weak self] in
        //        let headerView = UserDetailHeaderView.rHeaderView()
        
        let headerView = UserDetailHeaderView.loadViewFromNib()
        headerView.didSelectUserName = {(userid) in
            
            print(userid)
            
        }
        
        return headerView
        }()
    
    //懒加载bottomview
    lazy var rMyBottomView : UserDetailBottomView = {
        let headerView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        headerView.delegate = self
        
        return headerView
    }()
    
    
    //修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        //        return .lightContent
        return changeStatusBarStyle
    }
    
}


extension UserDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        
        
        
        if offsetY < -44 {
            let totalOffset = kUserDetailHeaderBgHeight + abs(offsetY)
            let f = totalOffset/kUserDetailHeaderBgHeight
            
            rHeaderView.rBackGroundView.frame = CGRect(x: -kScreenWidth * (f - 1) * 0.5, y: offsetY, width: kScreenWidth*f, height: totalOffset)
            rNavigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
            
        }
//        else if offsetY == 0 {
//            for subView in rHeaderView.rBottomScrollerView.subviews{
//                let tabView = subView as! UITableView
//                tabView.isScrollEnabled = false
//            }
//        }
        else {
            
            var alphaTitle: CGFloat = offsetY / 57
            //14+15+14
            if offsetY >= 43 {
                alphaTitle = min(alphaTitle, 1.0)
                rNavigationBar.rNameLabel.isHidden = false
                rNavigationBar.rNameLabel.textColor = UIColor(r: 0, g: 0, b: 0,alpha: alphaTitle)
                
            }else {
                alphaTitle = min(alphaTitle, 0.0)
                rNavigationBar.rNameLabel.textColor = UIColor(r: 0, g: 0, b: 0,alpha: alphaTitle)
                
                //            rNavigationBar.rNameLabel.isHidden = true
            }
            
            
            var alpha: CGFloat = (offsetY + 44) / 58
            
            alpha = min(alpha, 1.0)
            rNavigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            
            if alpha == 1.0{
                changeStatusBarStyle = .default
            }else {
                changeStatusBarStyle = .lightContent
            }
            
            
        
           
            if offsetY >=  rHeaderView.rTopTabView.frame.minY + rHeaderView.rBaseView.frame.minY - rNavigationBar.height {
                 rHeaderView.y = offsetY - (rHeaderView.rTopTabView.frame.minY + rHeaderView.rBaseView.frame.minY - rNavigationBar.height)

                for subView in rHeaderView.rBottomScrollerView.subviews{
                    let tabView = subView as! UITableView
                    tabView.isScrollEnabled = true
                }
            }else {
                rHeaderView.y = 0
 
                for subView in rHeaderView.rBottomScrollerView.subviews{
                    let tabView = subView as! UITableView
                    tabView.isScrollEnabled = false
                }
            }
            
        }
        
        
    }
}


extension UserDetailController: UserDetailBottomDelegate {
    func bottomViewClick(_ rSelectBtn: UIButton, _ rBottomTabModel: BottomTab) {
        let bottomPushVC = UserDetailBottomPushController()
        bottomPushVC.navigationItem.title = "网页浏览"
        
        if rBottomTabModel.children.count == 0{ //直接跳转到下个控制器
            
            bottomPushVC.rUrl = rBottomTabModel.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
            
        }else { //弹窗子视图
            
            let rStoryBoard = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            
            let pooVC = rStoryBoard.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            
            pooVC.rChildrenModel = rBottomTabModel.children
            pooVC.modalPresentationStyle = .custom
            pooVC.rDidSelectChild = {
                
                
                bottomPushVC.rUrl = $0.value
                self.navigationController?.pushViewController(bottomPushVC, animated: true)
                
            }
            
            let popAnimal = PopoverAnimator()
            
            //转化frame
            let rect = rBottomView.convert(rSelectBtn.frame, to: view)
            
            let popWith = (kScreenWidth - CGFloat(rUserModel!.bottom_tab.count + 1) * 20) / CGFloat(rUserModel!.bottom_tab.count)
            let popX = CGFloat(rSelectBtn.tag) * (popWith + 20) + 20
            let podHeigh = CGFloat(rBottomTabModel.children.count)*40 + 25
            popAnimal.presentFrame = CGRect(x: popX, y: rect.origin.y - podHeigh, width: popWith, height: podHeigh)
            
            pooVC.transitioningDelegate = popAnimal
            
            
            present(pooVC, animated: false, completion: nil)
        }
    }
    
    
    
}
