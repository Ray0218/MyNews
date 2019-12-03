//
//  HomeViewController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/21.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    lazy var rNavigationBar: HomeNavigationBar = {
        
        let navBar = HomeNavigationBar.loadViewFromNib()
        return navBar
    }()
    
    lazy var rTitleLabel: UILabel = {
        
        let label = UILabel.init()
        label.text = "文字内容"
        return label
        
        
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        
        
    }
    
    
}


extension HomeViewController {
    
    
    
    
    func setUpUI ()  {
        
        view.backgroundColor = UIColor(red: 29/255.0, green: 95/255.0, blue: 66/255.0, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = rNavigationBar
        
        view.addSubview(rTitleLabel)
        rTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        rTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalToSuperview()
            //            make.top.equalTo(rNavigationBar.snp.bottom)
            //            make.center.equalTo(view)
            make.edges.equalToSuperview().priority(.low)
        }
        
        //点击头像按钮
        rNavigationBar.didSelectAvatarButton = { [weak self] in
            
            self?.navigationController?.pushViewController(MineViewController(), animated: true)
            
        }
        
        rNavigationBar.didSelectSearchButton = {
            
        }
        
        
        let scrollView = getScrollerView(rFrame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 45), numberOfLabel: { () -> Int in
            return 16
        }) { (Index) -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            return label
            
        }
        view.addSubview(scrollView)
        
        
        //MARK: 系统原生请求
        
        var request = URLRequest(url: URL(string: "http://aqicn.org/publishingdata/json")!,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 30)
        request.httpMethod = "GET"
 
        let sessin = URLSession.shared

        let task = sessin.dataTask(with: request ) { (data, response, error) in
            print(error as Any)
            
            if data == nil {
                return
            }
 
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            print(json as Any )
            
        }
        
        task.resume()
        
 
        
    }
    
    
    func getScrollerView(rFrame: CGRect,numberOfLabel: ()-> Int,labelOfIndex:(_ index: Int) -> UILabel) -> UIScrollView  {
        
        
        let scVC  = UIScrollView(frame: rFrame)
        
        
        let countLab = numberOfLabel()
        
        let labWidth = 60
        for i in 0..<countLab {
            
            let labe = labelOfIndex(i)
            labe.text = "num\(i)"
            labe.frame = CGRect(x:labWidth * i , y: 0, width: labWidth, height:  Int(rFrame.height))
            labe.backgroundColor = UIColor(r: CGFloat(arc4random()%255), g: CGFloat(arc4random()%255), b: CGFloat(arc4random()%255))
            scVC.addSubview(labe)
        }
        
        scVC.contentSize = CGSize(width: CGFloat(labWidth * countLab), height: rFrame.height)
        scVC.backgroundColor = UIColor.white
        return scVC
        
    }
    
    
    
    
}
