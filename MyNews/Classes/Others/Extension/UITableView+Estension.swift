//
//  UITableView+Estension.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

extension UITableView {
    //注册cell
    func k_registerCell<T : UITableViewCell>(cell:T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellReuseIdentifier: T.identifier)

        }
    }
    
    //从缓存中取Cell
    func k_dequenueReusableCell<T:UITableViewCell>(indexPath:IndexPath) -> T where T:RegisterCellOrNib  {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
        
        //                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyFirstSectionCell.self)) as! MyFirstSectionCell

    }
    
    
}

