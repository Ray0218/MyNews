//
//  MyNavigationBarView.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyNavigationBarView: UIView,NibLoadable {
    
    var goBackButtonClicked: (() -> ())?
    
    @IBOutlet weak var rNameLabel: UILabel!
    
    @IBOutlet weak var rNavBarView: UIView!
    @IBOutlet weak var rReturnButton: UIButton!
    
    @IBOutlet weak var rMoreButton: UIButton!
    
    
    @IBAction func pvt_return(_ sender: UIButton) {
        goBackButtonClicked?()

    }
    
    
    @IBAction func pvt_more(_ sender: UIButton) {
    }
    
    class func loadNavBarView() -> MyNavigationBarView  {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! MyNavigationBarView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        height = rNavBarView.frame.maxY
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    

}
