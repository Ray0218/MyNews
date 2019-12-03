//
//  MyTabBarController.swift
//  MyNews
//
//  Created by 吴孔亮 on 2019/8/21.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245/255.5, green: 90/255.0, blue: 93/255.0, alpha: 1)
        

        // Do any additional setup after loading the view.
        addChildViewControllers()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(receviceNotifuceation(notifucation:)), name: NSNotification.Name(rawValue: "dayorNightButtonClick"), object: nil)
 
    }
    
    
    @objc func receviceNotifuceation(notifucation:Notification)  {
        
        let isNight = notifucation.object as! Bool
        
         if isNight { //夜间
           
              for childController in children{
                
                switch childController.title! {
                    
                case "首页":
                    setNightChildViewController(childController, "home")
                    break
                    
                case "视频":
                    setNightChildViewController(childController, "video")

                    break
                case "小视频":
                    setNightChildViewController(childController, "huoshan")
                    
                    break
                case "微头条":
                    setNightChildViewController(childController, "weitoutiao")
                    
                    break
 
                default:
                    break
                }
            }
                
 
        } else {
            
            for childController in children{
                
                switch childController.title! {
                    
                case "首页":
                    setDayChildViewController(childController, "home")
                    break
                    
                case "视频":
                    setDayChildViewController(childController, "video")
                    
                    break
                case "小视频":
                    setDayChildViewController(childController, "huoshan")
                    
                    break
                case "微头条":
                    setDayChildViewController(childController, "weitoutiao")
                    
                    break
                    
                default:
                    break
                }
            }
        }
        
        
    }
    
    
   private func  addChildViewControllers() {
        
        setChildViewController(HomeViewController(), "首页", "home")
        setChildViewController(VideoViewController(), "视频", "video")
        setChildViewController(HuoshanViewController(), "小视频", "huoshan")
        setChildViewController(WeiTouTiaoViewController(), "微头条", "weitoutiao")
        
        setValue(MyUITabBar(), forKey: "tabBar")
    }
    
  private  func setChildViewController(_ childViewController:UIViewController,_ title:String,_ imageName:String)  {
    
    
    if UserDefaults.standard.bool(forKey: kIsNight) {
        setNightChildViewController(childViewController, imageName)
    }else {
        setDayChildViewController(childViewController, imageName)

    }
        
//        childViewController.tabBarItem.image = UIImage(named: imageName)
//        childViewController.tabBarItem.selectedImage = UIImage(named: selectImageName)
//        childViewController.tabBarItem.title = title
//        childViewController.navigationItem.title = title
         childViewController.title = title
        let navVC  = MyNavigationController(rootViewController: childViewController)
        
        addChild(navVC)
        
    }
    
    //设置夜间控制器
    private  func setNightChildViewController(_ childViewController:UIViewController,_ imageName:String)  {
        
        childViewController.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        childViewController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
     }
    
    //设置日间控制器
    private  func setDayChildViewController(_ childViewController:UIViewController,_ imageName:String)  {
        
        childViewController.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        childViewController.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
        
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
