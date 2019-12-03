//
//  MoreLoginController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginController: AnimatableModalViewController {
    @IBOutlet weak var rTopLabel: UILabel!
    
    @IBOutlet var rMobileView: UIView!
    
    @IBOutlet weak var rPassWordView: AnimatableView!
    //发送验证码按钮
    @IBOutlet weak var rSendVertifyBtn: UIButton!
    //找回密码按钮
    @IBOutlet weak var rFindPassBtn: UIButton!
    //手机号输入框
    @IBOutlet weak var rMobileTestField: UITextField!
    //密码输入框
    @IBOutlet weak var rPassTextField: UITextField!
    //未注册提示
    @IBOutlet weak var rMiddleTipLab: UILabel!
    //进入头条
    @IBOutlet weak var rEnterToutiaoBtn: AnimatableButton!
    //阅读按钮
    @IBOutlet weak var rReadBtn: UIButton!
    //账号密码登录
    @IBOutlet weak var rLoginModelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.theme_backgroundColor = "colors.black"
        rLoginModelBtn.setTitle("免密码登录", for: .selected)
        
        rReadBtn.setImage(UIImage(named: "details_choose_icon_15x15_"), for: .selected)
        rReadBtn.setImage(UIImage(named: "details_choose_ok_icon_15x15_"), for: .normal)
        
        
    }
    
    @IBAction func pvt_loginModelClick(_ sender: UIButton) {
        
        rLoginModelBtn.isSelected = !sender.isSelected
        rSendVertifyBtn.isHidden = sender.isSelected
        rFindPassBtn.isHidden = !sender.isSelected
        rMiddleTipLab.isHidden = sender.isSelected
        rPassTextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        rTopLabel.text = sender.isSelected ? "账号密码登录" : "登录你的头条,精彩永不消失"
        
    }
    
    
    @IBAction func pvt_readProtocol(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func pvt_disMiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
