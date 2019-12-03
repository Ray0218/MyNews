//
//  MyFirstSectionCell.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/23.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit


protocol MyFirstCellDelegate  {
    //点击了第几个cell
    func MyFirstSectionCellClick(_ firstCell : MyFirstSectionCell, myConcerModel : MyConcernModel)
}

class MyFirstSectionCell: UITableViewCell, RegisterCellOrNib {
    
    var delegate: MyFirstCellDelegate?
    
    
    @IBOutlet weak var rTitleLabel: UILabel!
    @IBOutlet weak var rRightLabel: UILabel!
    @IBOutlet weak var rCollectionView: UICollectionView!
    
    
    
    var rConcernModelsArray = [MyConcernModel]() {
        didSet {
            rCollectionView.reloadData()
        }
        
    }
    
    
    
    var rConcernModel : MyConcernModel? {
        didSet {
            
        }
    }
    
    
    var rOhterModel : MyCellModel? {
        didSet {
            
            rTitleLabel?.text = rOhterModel?.text
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        rCollectionView.collectionViewLayout = MyConcernFlowLayout()
        rCollectionView.delegate = self
        rCollectionView.dataSource = self
        rCollectionView.k_registerCell(cell: MyConcenCollectionCell.self)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension MyFirstSectionCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return rConcernModelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.k_dequenueReusableCell(indexPath: indexPath) as MyConcenCollectionCell
        cell.myConcernModel = rConcernModelsArray[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myConcerMode = rConcernModelsArray[indexPath.item]
        delegate?.MyFirstSectionCellClick(self, myConcerModel: myConcerMode)
    }
    
}




class MyConcernFlowLayout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        itemSize = CGSize(width: 58, height: 74)
        //横向间距
        minimumLineSpacing = 0
        //纵向间距
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}
