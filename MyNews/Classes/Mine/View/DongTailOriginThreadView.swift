//
//  DongTailOriginThreadView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/29.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class DongTailOriginThreadView: UIView,NibLoadable {
      @IBOutlet weak var rContentLabel: RichLabel!
     @IBOutlet weak var rContentLabelHeigh: NSLayoutConstraint!
    @IBOutlet weak var rCollectionView: DongTaiCollectionView!
    
    
    var originThread: DongtaiOriginThread? {
        
        didSet {
//             如果原内容已经删除
            if originThread!.delete || !originThread!.show_origin {
                rContentLabel.text = originThread!.show_tips != "" ? originThread?.show_tips : originThread?.content
                rContentLabel.textAlignment = .center
                rContentLabelHeigh.constant = originThread!.contentH
            } else {
//                rContentLabel.text = originThread!.content
                rContentLabel.attributedText = originThread?.attributedContent

                rContentLabelHeigh.constant = originThread!.contentH
                rCollectionView.thumbImageList = originThread!.thumb_image_list
                rCollectionView.largeImageList = originThread!.large_image_list

                layoutIfNeeded()
            }
        }
    }
    
    

  override  func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        height = originThread!.height
    }
    
    
}
