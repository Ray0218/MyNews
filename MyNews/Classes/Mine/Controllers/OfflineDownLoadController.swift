//
//  OfflineDownLoadController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class OfflineDownLoadController: UITableViewController {

    
    var titlesArray = [HomeNewsTitle]()
    
    //数据库表
    let newsTitleTable = NewsTitleTable()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       tableView.k_registerCell(cell: OfflineDownCell.self)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 45
        
        //网络加载数据
        NetWorkTool.loadHomeNewsTitleData { (titles) in
            
            //插入数据库
           self.newsTitleTable.insert(titles)
            
            self.titlesArray = titles
            self.tableView.reloadData()
        }
        
        //从数据库中取出数据
        titlesArray = newsTitleTable.selectAll()
        
        
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titlesArray.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequenueReusableCell(indexPath: indexPath) as OfflineDownCell

        let model = self.titlesArray[indexPath.row]
        
cell.rTitleLabel.text = model.name
        return cell
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenHeigh, height: 44))
        view.backgroundColor = UIColor.lightGray
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        
        label.text = "我的频道"
        view.addSubview(label)
        
        return view
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var newsTitle = titlesArray[indexPath.row]
        newsTitle.selected = !newsTitle.selected
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownCell
        cell.rRightImgView.isHighlighted = newsTitle.selected
        
 
        //更新数据库
        newsTitleTable.update(newsTitle)
    }
}
