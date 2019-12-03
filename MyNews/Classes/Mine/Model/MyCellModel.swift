//
//  MyCellModel.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import Foundation
import HandyJSON

struct MyCellModel : HandyJSON{
    
    var grey_text : String = ""
    var text: String = ""
    var url: String = ""
    var key: String = ""
    var tip_new : Int = 0
    
}


struct MyConcernModel : HandyJSON {
    
    
    var icon : String? //"http:\/\/p1.pstatp.com\/thumb\/78f001cf0eb63e33613",
    //    "name" : "野食小哥",
    //    "tips" : false,
    //    "type" : "media",
    //    "url" : "sslocal:\/\/profile?refer=all&user_id=6928968165&uid=6928968165&enter_from=my_follow",
    //    "is_verify" : 1,
    //    "user_auth_info" : "{\"auth_type\":\"1\",\"auth_info\":\"知名美食领域创作者\",\"other_auth\":{\"interest\":\"知名美食领域创作者\"}}",
    //    "media_id" : 0,
    //    "id" : 6928968165,
    //    "userid" : 6928968165
    //
    
    var name : String?
    var tips : Bool?
    var type : String?
    var url : String?
    var is_verify : Bool?
    var media_id : Int?
    var id : Int?
    var userid : Int?
    
    
    var user_auth_info: String?
    var userInfo: UserAuthInfo? {
        return UserAuthInfo.deserialize(from: user_auth_info)
    }
    
    
}


struct UserAuthInfo: HandyJSON {
    var auth_type: Int?
    var auth_info: String?
}
