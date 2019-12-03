//
//  UserDetailBottomPopController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class UserDetailBottomPopController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var rDidSelectChild: ((BottomTabChildren) -> ())?
    

    var rChildrenModel = [BottomTabChildren]()
    
    @IBOutlet weak var rTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       rTableView.delegate = self
        rTableView.dataSource = self
        rTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UserDetailBottomPushController.self))
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return rChildrenModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserDetailBottomPushController.self), for: indexPath)
        cell.selectionStyle = .none
        let model = rChildrenModel[indexPath.row]
        
        cell.textLabel?.text = model.name
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rDidSelectChild?(rChildrenModel[indexPath.row])
        
        NotificationCenter.default.post(name: Notification.Name(kDismissModalView), object: nil)
    }
}
