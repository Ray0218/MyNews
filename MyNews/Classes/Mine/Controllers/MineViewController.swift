//
//  MineViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/21.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MineViewController: UITableViewController {
    
    
     let disposeBg = DisposeBag()
    
    var  sectionArr = [[MyCellModel]]()
    
    var  connerArr = [MyConcernModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        tableView.tableHeaderView = rHeaderView
        tableView.backgroundColor = UIColor.globalBackColor()
        tableView.tableFooterView = UIView()
        tableView.register(MyOtherCell.self, forCellReuseIdentifier: "cell")
        
        tableView.register(UINib(nibName: String(describing: MyFirstSectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyFirstSectionCell.self))
 
//        tableView.k_registerCell(cell: MyFirstSectionCell.self)
 
        NetWorkTool.loadMyCellData { (sections) in
 
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcoerns = [MyCellModel]()
            
            myConcoerns.append(myConcern!)
            
            
            self.sectionArr.append(myConcoerns)
            self.sectionArr += sections
            self.tableView.reloadData()
            
            
            NetWorkTool.loadMyConcern { (concersArr) in
                print(concersArr)
                
                self.connerArr = concersArr
                
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
        
        
        rHeaderView.rMoreButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            let storyBoard = UIStoryboard(name: String(describing: MoreLoginController.self), bundle: nil)
            
            let moreLoginVC = storyBoard.instantiateViewController(withIdentifier: String(describing: MoreLoginController.self)) as! MoreLoginController
            moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(kScreenHeigh-(isIphoneX ? 44 : 20))))
            moreLoginVC.modalPosition = .bottomCenter //底部对齐
            
            self!.present(moreLoginVC, animated: true, completion: nil)
            
        }).addDisposableTo(disposeBg)
        
    }
    
    
    
    
    fileprivate var rHeaderView: NoLoginHeaderView  = {
        let headerViewe = NoLoginHeaderView.rHeaderView()
        return headerViewe
    }()
    
    
    //修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
    }
    
    
    
}


extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArr[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyFirstSectionCell.self), for: indexPath) as! MyFirstSectionCell
            
//            let cell = tableView.k_dequenueReusableCell(indexPath: indexPath) as MyFirstSectionCell
            
            
            //        nib 方式
            //        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
            
            //             cell.rTitleLabel?.text = sectionArr[indexPath.section][indexPath.row].text
            
            cell.rOhterModel = sectionArr[indexPath.section][indexPath.row]
            
            if (connerArr.count == 0 || connerArr.count == 1) {
                cell.rCollectionView.isHidden = true
            }
            
            if (connerArr.count == 1){
                cell.rConcernModel = connerArr[0]
            }
            
            if (connerArr.count > 1){
                cell.rConcernModelsArray = connerArr
            }
            cell.delegate = self
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //        nib 方式
        //        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
        
        
        cell.textLabel?.text = sectionArr[indexPath.section][indexPath.row].text
        
        return cell
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeigh))
        view.backgroundColor = UIColor.globalBackColor()
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            return (connerArr.count == 0 || connerArr.count == 1) ? 40 : 114
        }
        return 40
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 3 && indexPath.row == 1 {
            
            let setVC = SettingTableViewController()
            navigationController?.pushViewController(setVC, animated: true)
        }
        
        
    }
    
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyheaderViewHeight + abs(offsetY)
            let f = totalOffset/kMyheaderViewHeight
            
            rHeaderView.rBgImageView.frame = CGRect(x: -kScreenWidth * (f - 1) * 0.5, y: offsetY, width: kScreenWidth*f, height: totalOffset)
        }
    }
    
    
    
}


extension MineViewController: MyFirstCellDelegate {
    
    //点击了第几个cell

    func MyFirstSectionCellClick(_ firstCell: MyFirstSectionCell, myConcerModel: MyConcernModel) {
        
        let userDetailVC = UserDetailController()
        if (myConcerModel.userid != nil){
        userDetailVC.rUserId = myConcerModel.userid!
        }
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
    
 
}
