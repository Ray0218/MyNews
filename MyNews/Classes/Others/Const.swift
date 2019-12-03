//
//  Const.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeigh = UIScreen.main.bounds.height

//服务器地址
let BASE_URL = "https://is.snssdk.com"

//let device_id : Int = 6096495334

let device_id : Int = 6096495918


let iid : Int = 5034850950

let newsTitleHeight: CGFloat = 40
let kMyheaderViewHeight: CGFloat = 280
let kUserDetailHeaderBgHeight: CGFloat = 146

let kIsNight: String = "isnight"


let isIphoneX: Bool = kScreenHeigh == 812 ? true :false

let kBottomSafeHeigh: CGFloat = isIphoneX ? 34 : 0


//关注的用户详情界面topTab的按钮宽度
let kTopTaButtonWidth : CGFloat = kScreenWidth * 0.2

let kTopTabindicatorWidth : CGFloat = 40
let kTopTabindicatorHeigh : CGFloat = 2


let kDismissModalView : String = "kDismissModalView"

/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = kScreenWidth * 0.5
let image2Width: CGFloat = (kScreenWidth - 35) * 0.5
let image3Width: CGFloat = floor((kScreenWidth - 40 ) / 3.0)


/// 从哪里进入问答控制器
enum WendaEnterFrom: String {
    case dongtai = "dongtai"
    case clickHeadline = "click_headline"
    case clickCategory = "click_category"
}

/// 从哪里进入头条
enum TTFrom: String {
    case pull = "pull"
    case loadMore = "load_more"
    case auto = "auto"
    case enterAuto = "enter_auto"
    case preLoadMoreDraw = "pre_load_more_draw"
}
