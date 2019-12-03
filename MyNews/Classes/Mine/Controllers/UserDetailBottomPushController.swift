//
//  UserDetailBottomPushController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/28.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {

    var rUrl : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: rUrl!)!))
        view.addSubview(webView)



    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
