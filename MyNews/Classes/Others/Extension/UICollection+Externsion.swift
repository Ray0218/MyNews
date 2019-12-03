//
//  UICollection+Externsion.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/23.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit


extension UICollectionView {
    //注册cell
    func k_registerCell<T : UICollectionViewCell>(cell:T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib,forCellWithReuseIdentifier: T.identifier)
        }else{
            register(cell, forCellWithReuseIdentifier: T.identifier)
            
        }
    }
    
    //从缓存中取Cell
    func k_dequenueReusableCell<T:UICollectionViewCell>(indexPath:IndexPath) -> T where T:RegisterCellOrNib  {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    
}
