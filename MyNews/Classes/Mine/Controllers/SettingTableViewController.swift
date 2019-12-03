//
//  SettingTableViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Kingfisher

class SettingTableViewController: UITableViewController {
    
    var sectionArray = [[SettingModel]]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionArray[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequenueReusableCell(indexPath: indexPath) as SettingTableViewCell
        
        cell.setting = sectionArray[indexPath.section][indexPath.row]
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: //
                
                caluateDiskCashSize(cell)
                
            default:
                break
            }
        default:
            break
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackColor()
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: //青龙缓存
                clearCacheAlterController(cell as! SettingTableViewCell)
            case 1: //设置字体大小
                SetFontAlterController(cell as! SettingTableViewCell)
            default:
                break
            }
            
            case 1:
            switch indexPath.row {
            case 0: // 离线下载
                navigationController?.pushViewController(OfflineDownLoadController(), animated: true)
            default:
                break
            }
        default:
            break
        }
        
    }
    
    
}


extension SettingTableViewController {
    
    
    //设置字体大小
    @objc fileprivate func SetFontAlterController(_ cell : SettingTableViewCell) {
        
        let AlterController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default) { (_) in
            
            cell.rRightLabel.text = "小" ;
            
        }
        let middleAction = UIAlertAction(title: "中", style: .default) { (_) in
            cell.rRightLabel.text = "中" ;
            
        }
        let bigAction = UIAlertAction(title: "大", style: .default) { (_) in
            cell.rRightLabel.text = "大"
            
        }
        
        let largeAction = UIAlertAction(title: "特大", style: .default) { (_) in
            
            cell.rRightLabel.text = "特大"
        }
        
        AlterController.addAction(cancelAction)
        AlterController.addAction(smallAction)
        AlterController.addAction(middleAction)
        AlterController.addAction(bigAction)
        AlterController.addAction(largeAction)
        present(AlterController, animated: true, completion: nil)
    }
    
    
    
    
    //获取缓存数据大小
    fileprivate func caluateDiskCashSize(_ cell : SettingTableViewCell) {
        
        let cache = KingfisherManager.shared.cache
        
        
        cache.calculateDiskCacheSize { (result) in
            
            
            let sizeM = Double(result)/1024.0/1024.0
            let sizeString  = String(format: "%.2fM", sizeM)
            
            cell.rRightLabel.text = sizeString
        }
    }
    
    
    
    
    
    //清理缓存弹窗,清除缓存
    @objc fileprivate func clearCacheAlterController(_ cell : SettingTableViewCell) {
        
        let AlterController = UIAlertController(title: "确定清理所有缓存?", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            let sizeString = "0.0M"
            //重设显示文字
            
            cell.rRightLabel.text = sizeString ;
            
        }
        
        AlterController.addAction(cancelAction)
        AlterController.addAction(confirmAction)
        present(AlterController, animated: true, completion: nil)
        
        
    }
    
}




extension SettingTableViewController {
    
    fileprivate func setUpUI( ) {
        
        
        //plist路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        //plist文件中的数据
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        
        
        for dicts in cellPlist {
            let array = dicts as! [[String: Any]]
            var rows = [SettingModel]()
            
            for dic in array {
                
                let setModel = SettingModel.deserialize(from: dic)
                rows.append(setModel!)
            }
            
            sectionArray.append(rows)
            
        }
        
       
        
        tableView.k_registerCell(cell: SettingTableViewCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.black"
        
    }
}
