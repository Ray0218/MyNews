//
//  NetWorkTool.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/22.
//  Copyright © 2019 Ray. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


protocol NetWorkToolProtocol {
    
    //    ____________首页_______________
    // MARK: 点击首页加号按钮，获取频道推荐数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ())
    // MARK: 获取图片新闻详情数据
    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->())
    
    // MARK: 视频顶部新闻标题的数据
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    // MARK: 视频详情数据
    static func loadArticleInformation(from: String, itemId: Int, groupId: Int, completionHandler: @escaping (_ videoDetail: VideoDetail) -> ())
    
    // MARK: 获取首页、视频、小视频的新闻列表数据
    static func loadApiNewsFeeds(category: String, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ())
    // MARK: 获取首页、视频、小视频的新闻列表数据,加载更多
    static func loadMoreApiNewsFeeds(category: String, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ())
    //离线下载数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ sections:[HomeNewsTitle]) -> ())
    // MARK: 首页顶部新闻导航栏搜索内容
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping (_ suggestInfo: String) ->())
    // MARK: 解析头条的视频真实播放地址
    static func parseVideoRealURL(video_id: String, completionHandler: @escaping (_ realVideo: RealVideo) -> ())
    
    
    // MARK: - - ---- 小视频  ------ -------
    // MARK: 小视频导航栏标题的数据
    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    
    //    ____________我的_______________
    //我的界面cell数据
    static func loadMyCellData(completionHandler:  @escaping(_ sections : [[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ sections:[MyConcernModel]) -> ())
    //获取用户详情
    static func loadUserDetailData(user_id:Int, completionHandler:@escaping (_ userDetail:UserDetailModel) -> ())
    //取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) ->())
    //点击关注按钮
    static func loadRelationFollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) ->())
    //点击关注按钮 就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandler: @escaping (_ concerns: [UserCard]) ->())
    
    ///获取用户详情的动态列表数据
    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,_ dongtais: [UserDetailDongtai]) -> ())
    ///获取用户详情的文章列表数据
    static func loadUserDetailArticleList(user_id: Int, completionHandler: @escaping (_ concerns: [UserDetailDongtai]) ->())
    /// 获取用户详情的问答列表数据
    /// - parameter userId: 用户id
    /// - parameter cursor: 加载更多数据的指示器
    /// - parameter completionHandler: 返回动态数据
    /// - parameter wendas:  问答数据的数组
    static func loadUserDetailWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ())
    
    /// 获取用户详情一般的详情的评论数据
    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
    
    /// 获取用户详情引用类型的详情的评论数据
    static func loadUserDetailQuoteDongtaiComents(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
    // MARK: 获取动态详情的用户点赞列表数据
    static func loadDongtaiDetailUserDiggList(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiUserDigg]) -> ())
    
    // MARK: 获取问答的列表数据（提出了问题）
    static func loadProposeQuestionBrow(qid: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())
    // MARK: 获取问答的列表数据（提出了问题），加载更多
    static func loadMoreProposeQuestionBrow(qid: Int, offset: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())
}


extension NetWorkToolProtocol {
    
    //    ____________首页_______________
    
    ///---------home------------
    /// 点击首页加号按钮，获取频道推荐数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter titles: 标题数据
    static func loadHomeCategoryRecommend(completionHandler:@escaping (_ titles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    completionHandler(data.compactMap({
                        HomeNewsTitle.deserialize(from: ($0 as! [String: Any]))
                    }))
                }
            }
        }
    }
    /// 获取图片新闻详情数据
    /// - parameter articleURL: 链接
    /// - parameter completionHandler: 返回图片数组，标题数组
    /// - parameter images: 图片数组
    /// - parameter abstracts: 标题数组
    static func loadNewsDetail(articleURL: String, completionHandler:@escaping (_ images: [NewsDetailImage], _ abstracts: [String])->()) {
        // 测试数据
        //        http://toutiao.com/item/6450211121520443918/
        let url = "http://www.toutiao.com/a6450237670911852814/#p=1"
        
        Alamofire.request(url).responseString { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                if value.contains("BASE_DATA.galleryInfo =") {
                    // 获取 图片链接数组
                    let startIndex = value.range(of: ",\\\"sub_images\\\":")!.upperBound
                    let endIndex = value.range(of: ",\\\"max_img_width\\\":")!.lowerBound
                    let BASE_DATA = value[Range(uncheckedBounds: (lower: startIndex, upper: endIndex))]
                    let substring = BASE_DATA.replacingOccurrences(of: "\\\\", with: "")
                    let substring2 = substring.replacingOccurrences(of: "\\", with: "")
                    let data = substring2.data(using: .utf8)! as Data
                    let dicts = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [Any]
                    // 获取 子标题
                    let titleStartIndex = value.range(of: "\\\"sub_abstracts\\\":")!.upperBound
                    let titlEndIndex = value.range(of: ",\\\"sub_titles\\\"")!.lowerBound
                    let sub_abstracts = value[Range(uncheckedBounds: (lower: titleStartIndex, upper: titlEndIndex))]
                    let titleSubstring1 = sub_abstracts.replacingOccurrences(of: "\\\"", with: "\"")
                    let titleSubstring2 = titleSubstring1.replacingOccurrences(of: "\\u", with: "u")
                    let titleData = titleSubstring2.data(using: String.Encoding.utf8)! as Data
                    completionHandler(dicts!.compactMap({ NewsDetailImage.deserialize(from: $0 as? [String: Any])! }), try! JSONSerialization.jsonObject(with: titleData, options: .mutableContainers) as! [String])
                }
            }
        }
    }
    /// 视频顶部新闻标题的数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 视频标题数组
    static func loadVideoApiCategoies(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].arrayObject {
                    var titles = [HomeNewsTitle]()
                    titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"video\", \"name\": \"推荐\"}")!)
                    titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                    completionHandler(titles)
                }
            }
        }
    }
    
    /// 视频详情数据
    /// - parameter from: 来源（click_video）
    /// - parameter itemId: item_id
    /// - parameter groupId: group_id
    /// - parameter completionHandler: 返回视频详情数据
    /// - parameter videoDetail: 视频详情数据
    static func loadArticleInformation(from: String, itemId: Int, groupId: Int, completionHandler: @escaping (_ videoDetail: VideoDetail) -> ()) {
        let url = BASE_URL + "/2/article/information/v23/?"
        let params = ["device_id": device_id,
                      "iid": iid,
                      "app_name": "news_article",
                      "version_code": "6.5.5",
                      "device_platform": "iphone",
                      "flags": 64,
                      "aid": 13,
                      "aggr_type": 1,
                      "article_page": 1,
                      "from": from,
                      "item_id": itemId,
                      "group_id": groupId] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                completionHandler(VideoDetail.deserialize(from: json["data"].dictionaryObject)!)
            }
        }
    }
    
    /// 解析头条的视频真实播放地址
    /// - [可参考这篇博客](http://blog.csdn.net/dianliang01/article/details/73163086)
    /// - parameter video_id: 视频 id
    /// - parameter completionHandler: 返回视频真实播放地址
    /// - parameter newsTitles: 视频真实播放地址
    static func parseVideoRealURL(video_id: String, completionHandler: @escaping (_ realVideo: RealVideo) -> ()) {
        
        let r = arc4random() // 随机数
        
        let url: NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
        let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        // 使用 crc32 校验
        var crc32: UInt64 =  UInt64(data.getCRC32())
        // crc32 可能为负数，要保证其为正数
        if crc32 < 0 { crc32 += 0x100000000 }
        // 拼接 url
        let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
        
        Alamofire.request(realURL).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                completionHandler(RealVideo.deserialize(from: JSON(value)["data"].dictionaryObject)!)
            }
        }
    }
    /// 获取首页、视频、小视频的新闻列表数据
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadApiNewsFeeds(category: String, ttFrom: TTFrom, _ completionHandler: @escaping (_ maxBehotTime: TimeInterval, _ news: [NewsModel]) -> ()) {
        // 下拉刷新的时间
        let pullTime = Date().timeIntervalSince1970
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": 15,
                      "category": category,
                      "min_behot_time": pullTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(pullTime, datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
            }
        }
    }
    
    /// 获取首页、视频、小视频的新闻列表数据,加载更多
    /// - parameter category: 新闻类别
    /// - parameter ttFrom: 那个界面
    /// - parameter listCount: 数据数量
    /// - parameter completionHandler: 返回新闻列表数据
    /// - parameter news: 首页新闻数据数组
    static func loadMoreApiNewsFeeds(category: String, ttFrom: TTFrom, maxBehotTime: TimeInterval, listCount: Int, _ completionHandler: @escaping (_ news: [NewsModel]) -> ()) {
        
        let url = BASE_URL + "/api/news/feed/v75/?"
        let params = ["device_id": device_id,
                      "count": 20,
                      "list_count": listCount,
                      "category": category,
                      "max_behot_time": maxBehotTime,
                      "strict": 0,
                      "detail": 1,
                      "refresh_reason": 1,
                      "tt_from": ttFrom,
                      "iid": iid] as [String: Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                guard let datas = json["data"].array else { return }
                completionHandler(datas.compactMap({ NewsModel.deserialize(from: $0["content"].string) }))
            }
        }
    }
    
    
    //离线下载数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ sections:[HomeNewsTitle]) -> ()) {
        
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,"iid":iid
        ]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误提示信息
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                
                if let dataDict = json["data"].dictionary{
                    
                    
                    if let data = dataDict["data"]?.arrayObject{
                        
                        var titlesArray = [HomeNewsTitle]()
                        
                        let jsonString  = "{\"category\":\"\",\"name\":\"推荐\"}"
                        
                        let recommendModel = HomeNewsTitle.deserialize(from: jsonString)
                        titlesArray.append(recommendModel!)
                        
                        for item in data {
                            let newsTitleModel = HomeNewsTitle.deserialize(from: item as? NSDictionary)
                            titlesArray.append(newsTitleModel!)
                            
                        }
                        
                        completionHandler(titlesArray)
                    }
                }
            }
        }
    }
    
    /// 首页顶部新闻导航栏搜索内容
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping (_ suggestInfo: String) ->()) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].dictionary {
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
            }
        }
        
    }
    
    
    /// 小视频导航栏标题的数据
    /// - parameter completionHandler: 返回标题数据
    /// - parameter newsTitles: 小视频标题数组
    static func loadSmallVideoCategories(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/category/get_ugc_video/1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]!.arrayObject {
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"hotsoon_video\", \"name\": \"推荐\"}")!)
                        titles += datas.compactMap({ HomeNewsTitle.deserialize(from: $0 as? Dictionary) })
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    //    ____________我的_______________
    //我的界面cell数据
    static func loadMyCellData(completionHandler: @escaping (_ sections : [[MyCellModel]]) -> ()){
        
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id":device_id]
        
        Alamofire.request(url,parameters:params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //网络错误提示信息
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                
                if let datas = json["data"].dictionary{
                    
                    
                    //                    if let sections = datas["sections"]?.array{
                    //
                    //                        var sectionArray = [[MyCellModel]]()
                    //
                    //                        for item in sections {
                    //
                    //                            var rows = [MyCellModel]()
                    //
                    //                            for row in item.arrayObject! {
                    //
                    //                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                    //                                rows.append(myCellModel!)
                    //
                    //                            }
                    //
                    //                            sectionArray.append(rows)
                    //
                    //                        }
                    //
                    //                        completionHandler(sectionArray)
                    //
                    //                     }
                    
                    if let sections = datas["sections"]?.arrayObject{
                        
                        completionHandler(sections.compactMap({ sections  in
                            
                            (sections as! [Any]).compactMap({ row  in
                                
                                MyCellModel.deserialize(from: row as? NSDictionary)
                            })
                        })
                        )
                    }
                }
            }
        }
        
    }
    //我的关注数据
    static func loadMyConcern(completionHandler:@escaping (_ sections:[MyConcernModel]) -> ()){
        
        let url = BASE_URL + "/concern/v2/follow/my_follow/??"
        
        let paragram = ["device_id":device_id]
        
        
        Alamofire.request(url,parameters:paragram).responseJSON { (response) in
            
            guard response.result.isSuccess else {return}
            
            if let value = response.result.value {
                
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                
                if let dataArray = json["data"].arrayObject {
                    
                    var conscenArr = [MyConcernModel]()
                    
                    /*
                     for data in dataArray {
                     
                     let rModel = MyConcernModel.deserialize(from: data as? NSDictionary)
                     
                     conscenArr.append(rModel!)
                     
                     }
                     completionHandler(conscenArr)
                     */
                    
                    
                    
                    
                    completionHandler(dataArray.flatMap({
                        MyConcernModel.deserialize(from: $0 as? NSDictionary)
                    }))
                    
                    
                    
                    
                }
                
                
            }
            
            
        }
        
    }
    
    //获取用户详情
    
    static func loadUserDetailData(user_id:Int, completionHandler:@escaping (_ userDetail:UserDetailModel) -> ()){
        
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        
        let paragram = ["device_id":device_id,
                        "user_id": user_id ,
                        "iid":iid
        ]
        
        
        Alamofire.request(url,parameters:paragram).responseJSON { (response) in
            
            guard response.result.isSuccess else {return}
            
            if let value = response.result.value {
                
                let json = JSON(value)
                guard json["message"] == "success" else{
                    return
                }
                
                if let data = json["data"].dictionaryObject {
                    
                    let userDetail = UserDetailModel.deserialize(from: data as Dictionary)
                    
                    completionHandler(userDetail!)
                    
                }
                
                
            }
            
            
        }
        
    }
    
    
    
    //取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) ->()){
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["device_id": device_id,
                      "iid": iid,
                      "user_id": user_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else{
                    if let data = json["data"].dictionaryObject {
                        //                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        //                        SVProgressHUD.setForegroundColor(UIColor.white)
                        //                        SVProgressHUD.setBackgroundColor(UIColor.init(r: 0, g: 0, b: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
                
            }
        }
    }
    
    ///点击关注按钮
    static func loadRelationFollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) ->()){
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["device_id": device_id,
                      "iid": iid,
                      "user_id": user_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else{
                    if let data = json["data"].dictionaryObject {
                        //                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        //                        SVProgressHUD.setForegroundColor(UIColor.white)
                        //                        SVProgressHUD.setBackgroundColor(UIColor.init(r: 0, g: 0, b: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
                
            }
        }
    }
    
    
    ///点击关注按钮 就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandler: @escaping (_ concerns: [UserCard]) ->()){
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["device_id": device_id,
                      "iid": iid,
                      "follow_user_id": user_id,
                      "scene": "follow",
                      "source": "follow"] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else{
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else{
                    return
                }
                if let user_cards = json["user_cards"].arrayObject {
                    completionHandler(user_cards.compactMap({
                        UserCard.deserialize(from: $0 as? Dictionary)
                    }))
                    
                }
                
            }
        }
    }
    
    
    
    /// 获取用户详情的动态列表数据
    /// - parameter userId: 用户id
    /// - parameter maxCursor: 刷新时间
    /// - parameter completionHandler: 返回动态数据
    /// - parameter dongtais:  动态数据的数组
    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,_ dongtais: [UserDetailDongtai]) -> ()) {
        
        let url = BASE_URL + "/dongtai/list/v15/?"
        let params = ["user_id": userId,
                      "max_cursor": maxCursor,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler(maxCursor, []); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { completionHandler(maxCursor, []); return }
                if let data = json["data"].dictionary {
                    let max_cursor = data["max_cursor"]!.int
                    if let datas = data["data"]!.arrayObject {
                        completionHandler(max_cursor!, datas.compactMap({
                            UserDetailDongtai.deserialize(from: $0 as? Dictionary)
                        }))
                    }
                }
            }
        }
    }
    
    ///获取用户详情的文章列表数据
    static func loadUserDetailArticleList(user_id: Int, completionHandler: @escaping (_ concerns: [UserDetailDongtai]) ->()){
        let url = BASE_URL + "/pgc/ma/?"
        let params = ["uid": user_id,
                      "page_type": 1,
                      "media_id": user_id,
                      "output": "json",
                      "is_json": 1,
                      "from": "user_profile_app",
                      "version": 2,
                      "as": "A1157A8297BEED7",
                      "cp": "59549FCDF1885E1"] as [String: Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].arrayObject {
                    completionHandler(data.compactMap({ UserDetailDongtai.deserialize(from: $0 as? Dictionary) }))
                }
            }
        }
    }
    
    /// 获取用户详情的问答列表数据
    /// - parameter userId: 用户id
    /// - parameter cursor: 加载更多数据的指示器
    /// - parameter completionHandler: 返回动态数据
    /// - parameter wendas:  问答数据的数组
    static func loadUserDetailWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ()) {
        
        let url = BASE_URL + "/wenda/profile/wendatab/brow/?"
        let params = ["other_id": userId,
                      "format": "json",
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler(cursor, []); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else { completionHandler(cursor, []); return }
                if let answerQuestions = json["answer_question"].arrayObject {
                    if answerQuestions.count == 0 { completionHandler(cursor, []) }
                    else {
                        completionHandler(json["cursor"].string!, answerQuestions.compactMap({
                            UserDetailWenda.deserialize(from: $0 as? Dictionary)
                        }))
                    }
                }
            }
        }
    }
    
    /// 获取用户详情的问答列表数据
    /// - parameter userId: 用户id
    /// - parameter cursor: 加载更多数据的指示器
    /// - parameter completionHandler: 返回动态数据
    /// - parameter wendas:  问答数据的数组
    static func loadUserDetailLoadMoreWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ()) {
        
        let url = BASE_URL + "/wenda/profile/wendatab/loadmore/?"
        let params = ["other_id": userId,
                      "format": "json",
                      "cursor": cursor,
                      "count": 10,
                      "offset": "undefined",
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler(cursor, []); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else { completionHandler(cursor, []); return }
                if let answerQuestions = json["answer_question"].arrayObject {
                    if answerQuestions.count == 0 { completionHandler(cursor, []) }
                    else {
                        completionHandler(json["cursor"].string!, answerQuestions.compactMap({
                            UserDetailWenda.deserialize(from: $0 as? Dictionary)
                        }))
                    }
                }
            }
        }
    }
    
    /// 获取用户详情一般的详情的评论数据
    /// item_type: postContent(200),postVideo(150),postVideoOrArticle(151)
    /// - parameter forumId: 用户id
    /// - parameter groupId: thread_id
    /// - parameter offset: 偏移
    /// - parameter completionHandler: 返回评论数据
    /// - parameter comments: 评论数据
    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ()) {
        
        let url = BASE_URL + "/article/v2/tab_comments/"
        let params = ["forum_id": "",
                      "group_id": groupId,
                      "count": count,
                      "offset": offset,
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
 
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler([]); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { completionHandler([]); return }
                if let datas = json["data"].arrayObject {
                    completionHandler(datas.compactMap({
                        return DongtaiComment.deserialize(from: ($0 as! [String: Any])["comment"] as? Dictionary)
                    }))
                }
            }
        }
    }
    
    
    /// 获取用户详情引用类型的详情的评论数据
    /// item_type: 109,212,110
    /// - parameter id: 详情的 id
    /// - parameter offset: 偏移
    /// - parameter completionHandler: 返回评论数据
    /// - parameter comments: 评论数据
    static func loadUserDetailQuoteDongtaiComents(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ()) {
        
        let url = BASE_URL + "/2/comment/v1/reply_list/?"
        let params = ["id": id,
                      "count": 20,
                      "offset": offset,
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler([]); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { completionHandler([]); return }
                if let data = json["data"].dictionary {
                    if let datas = data["data"]!.arrayObject {
                        completionHandler(datas.compactMap({ DongtaiComment.deserialize(from: $0 as? Dictionary) }))
                    }
                }
            }
        }
    }
    
    /// 获取动态详情的用户点赞列表数据
    /// - parameter id: id
    /// - parameter offset: 偏移
    /// - parameter completionHandler: 返回用户点赞列表数据
    /// - parameter comments: 用户点赞列表数据
    static func loadDongtaiDetailUserDiggList(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiUserDigg]) -> ()) {
        let url = BASE_URL + "/2/comment/v1/digg_list/?"
        let params = ["id": id,
                      "count": 20,
                      "offset": offset,
                      "device_id": device_id,
                      "iid": iid] as [String : Any]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { completionHandler([]); return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { completionHandler([]); return }
                if let data = json["data"].dictionary {
                    if let datas = data["data"]!.arrayObject {
                        completionHandler(datas.compactMap({ DongtaiUserDigg.deserialize(from: $0 as? Dictionary) }))
                    }
                }
            }
        }
    }
    
    /// 获取问答的列表数据（提出了问题）
    /// proposeQuestion(1029)
    /// - parameter id: id
    /// - parameter enterFrom: 从哪里进入（dongtai(动态中问答),click_category(问答分类),click_headline(推荐中问答)）
    /// - parameter completionHandler: 返回用问答数据
    /// - parameter wenda: 问答数据
    static func loadProposeQuestionBrow(qid: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ()) {
        let url = BASE_URL + "/wenda/v1/question/brow/?device_id=\(device_id)&iid=\(iid)"
        let params = ["qid": qid,
                      "enter_form": enterForm] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else { return }
                completionHandler(Wenda.deserialize(from: json.dictionaryObject)!)
            }
        }
    }
    
    /// 获取问答的列表数据（提出了问题），加载更多
    /// proposeQuestion(1029)
    /// - parameter id: id
    /// - parameter offset: 偏移
    /// - parameter enterFrom: 从哪里进入（dongtai(动态中问答),click_category(问答分类),click_headline(推荐中问答)）
    /// - parameter completionHandler: 返回用问答数据
    /// - parameter wenda: 问答数据
    static func loadMoreProposeQuestionBrow(qid: Int, offset: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ()) {
        let url = BASE_URL + "/wenda/v1/question/loadmore/?device_id=\(device_id)&iid=\(iid)"
        let params = ["qid": qid,
                      "count": 20,
                      "offset": offset,
                      "enter_form": enterForm] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else { return }
                completionHandler(Wenda.deserialize(from: json.dictionaryObject)!)
            }
        }
    }
}








struct NetWorkTool: NetWorkToolProtocol {
   
    
   
    
    
}
