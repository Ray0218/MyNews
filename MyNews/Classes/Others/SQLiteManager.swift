//
//  SQLiteManager.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/26.
//  Copyright © 2019 Ray. All rights reserved.
//

import Foundation
import SQLite

struct SQLiteManager {
    // 数据库链接
    var database: Connection!
    
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            database = try Connection(path)
        } catch { print(error) }
    }
    
}

/// 首页新闻分类的标题数据表
struct NewsTitleTable {
    /// 数据库管理者
    private let sqlManager = SQLiteManager()
    /// 新闻标题 表
    private let news_title = Table("news_title")
    /// 表字段
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let tip_new = Expression<Int64>("tip_new")
    let default_add = Expression<Int64>("default_add")
    let web_url = Expression<String>("web_url")
    let concern_id = Expression<String>("concern_id")
    let icon_url = Expression<String>("icon_url")
    let flags = Expression<Int64>("flags")
    let type = Expression<Int64>("type")
    let name = Expression<String>("name")
    let selected = Expression<Bool>("selected")
    
    init() {
        // 建表
        try! sqlManager.database.run(news_title.create(ifNotExists: true, block: { t in
            t.column(id, primaryKey: true)
            t.column(category)
            t.column(tip_new)
            t.column(default_add)
            t.column(web_url)
            t.column(concern_id)
            t.column(icon_url)
            t.column(flags)
            t.column(type)
            t.column(name)
            t.column(selected)
        }))
    }
    
    /// 插入一组数据
    func insert(_ titles: [HomeNewsTitle]) { _ = titles.map { insert($0) }}
    /// 插入一条数据
    func insert(_ title: HomeNewsTitle) {
        /// 如果数据库中该条数据数据不存在，就插入
        if !exist(title) {
            let insert = news_title.insert(category <- title.category, tip_new <- Int64(title.tip_new), default_add <- Int64(title.default_add), concern_id <- title.concern_id, web_url <- title.web_url, icon_url <- title.icon_url, flags <- Int64(title.flags), type <- Int64(title.type), name <- title.name, selected <- title.selected)
            /// 插入数据
            try! sqlManager.database.run(insert)
        }
    }
    
    /// 判断数据库中某一条数据是否存在
    func exist(_ title: HomeNewsTitle) -> Bool {
        // 取出该新闻分类标题的数据
        let title = news_title.filter(category == title.category)
        // 判断该条数据是否存在，没有直接的方法
        // 可以根据 count 是否是 0 来判断是否存在这条数据，0 表示没有该条数据，1 表示存在该条数据
        let count = try! sqlManager.database.scalar(title.count)
        return count != 0
    }
    
    /// 查询所有数据
    func selectAll() -> [HomeNewsTitle] {
        var allTitles = [HomeNewsTitle]()
        // 遍历表中数据
        for title in try! sqlManager.database.prepare(news_title) {
            // 取出表中数据，并初始化为一个结构体模型
            let newsTitle = HomeNewsTitle(category: title[category], tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])

//            let newsTitle = HomeNewsTitle(category: NewsTitleCategory(rawValue: title[category])!, tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])
            // 添加到数组中
            allTitles.append(newsTitle)
        }
        return allTitles
        // 不再使用 map 方式
        //        let newsTitles = try! sqlManager.database.prepare(news_title)
        //        return newsTitles.map({ title in
        //            // 取出表中数据，并初始化为一个结构体模型
        //            HomeNewsTitle(category: title[category], tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])
        //        })
    }
    
    /// 更新数据
    func update(_ newsTitle: HomeNewsTitle) {
        // 取出数据库中数据
        let title = news_title.filter(category == newsTitle.category)
        // 更新数据
        try! sqlManager.database.run(title.update(selected <- newsTitle.selected))
    }
    
}



//import SQLite
//
//
//
//
//struct SQLiteManager {
//    var dataBase: Connection!
//    init() {
//        do {
//            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
//
//            dataBase = try Connection(path)
//
//        } catch   {
//            print(error)
//        }
//    }
//
//}
//
//
//struct NewsTitleTable {
//    //数据库管理者
//   let sqManager = SQLiteManager()
//
//    //新闻标题类
//    let news_title = Table("new_title")
//
//    //表字段
//    let id = Expression<Int64>("id")
//    let category = Expression<String>("category")
//    let tip_new = Expression<String>("tip_new")
//     let type = Expression<String>("type")
//     let name = Expression<String>("name")
//    let selected = Expression<Bool>("selected")
//
//    init() {
//        do {
//
//            //建表
//            try  sqManager.dataBase.run(news_title.create(ifNotExists: true,block:{
//                t in
//
//                t.column(id,primaryKey: true)
//                t.column(category)
//                t.column(tip_new)
//                t.column(type)
//                t.column(name)
//                t.column(selected)
//            }))
//        } catch   {
//            print(error)
//        }
//    }
//
//    //插入一条数据
//    func insert(_ title: HomeNewsTitle)  {
//
//        if !esist(title) {
//            let insert = news_title.insert(category <- title.category,id <- Int64(title.id),name <- title.name, type <- title.type,selected <- title.selected )
//            do {
//                try sqManager.dataBase.run(insert)
//
//            }catch{
//                print(error)
//            }
//
//        }
//
//    }
//
//
//    //插入一组数据
//    func insert(_ titles: [HomeNewsTitle])  {
//
//        for title in titles{
//            insert(title)
//        }
//    }
//
//    //判断数据是否存在
//    func esist(_ title:HomeNewsTitle) -> Bool {
//        //取出该新闻分类的标题数据
//        let title = news_title.filter(category == title.category)
//
//        do {
//            //判断该条数据是否存在,根据count是否为0判断
//          let count =  try sqManager.dataBase.scalar(title.count)
//
//            return count != 0
//        } catch  {
//
//        }
//
//        return false
//    }
//
//    //查询所有
//    func selectAll() -> [HomeNewsTitle] {
//        var allTitles = [HomeNewsTitle]()
//
//        do {
//            for title in try sqManager.dataBase.prepare(news_title){
//
//                let newsTitle = HomeNewsTitle(id: Int64(title[id]), category: title[category], tip_new: title[tip_new], type: title[type], name: title[name], selected: title[selected])
//
//                allTitles.append(newsTitle)
//
//            }
// return allTitles
//
//        } catch  {
//
//        }
//        return []
//    }
//
//
//    //更新数据
//    func update(_ newsTitle : HomeNewsTitle)  {
//        do {
//            let  title = news_title.filter(category == newsTitle.category )
//            //更新数据选中状态
//             try sqManager.dataBase.run(title.update(selected <- newsTitle.selected))
//
//         } catch   {
//            print(error)
//        }
//    }
//
//}
//
