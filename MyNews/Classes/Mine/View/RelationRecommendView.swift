//
//  RelationRecommendView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView,NibLoadable{

    @IBOutlet weak var rReCommendLabelHeigh: NSLayoutConstraint!
    
    @IBOutlet weak var rollectionView: UICollectionView!
    
    var rUserCardsModel = [UserCard](){
        didSet {
            self.rollectionView.reloadData()
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rollectionView.delegate = self
        rollectionView.dataSource = self
        rollectionView.k_registerCell(cell: RelationRecommendCollectionCell.self)
        rollectionView.collectionViewLayout = RelationRecommendFlowLayout()
    }
    
}


extension RelationRecommendView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rUserCardsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as RelationRecommendCollectionCell
        
        cell.rUserCardModel = rUserCardsModel[indexPath.item]
        
        return cell
    }
    
    
}


class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
