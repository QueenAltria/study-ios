//
//  MainTabBarViewController.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/29.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var home=HomeViewController()
    var find=FindViewController()
    var collection=CollectionViewController()
    var more=MoreViewController()
    var beforeChoose:String?=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItem = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]//未点击颜色
        let attrs_Select = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: normalColor]//点击后颜色
        tabBarItem.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBarItem.setTitleTextAttributes(attrs_Select, for: .selected)
        //tabBarItem.setTitleTextAttributes(attrs_Normal, for: UIControlState.normal)
        tabBar.tintColor=normalColor //设置选中的颜色
        setupUI()
        
        //Thread.sleep(forTimeInterval: 10.0) //延长10秒
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //可以在点击之后滚动到首页
        if item.title==beforeChoose{
            let _title=item.title
            if _title=="首页"{
                
            }else if _title=="发现"{
                
            }else if _title=="收藏"{
                
            }else if _title=="更多"{
                
            }
        }else{
            beforeChoose=item.title
        }
        //print("didSelect\(item.title):\(item.tag)")
    }
}

extension MainTabBarViewController {
    
    fileprivate func setupUI () {
        let viewControllersArray : [UIViewController]  = [home,find,collection,more]
        
        let titlesArray = [("首页", "bottom_home"), ("发现", "bottom_find"),
                           ("收藏", "bottom_collection"),("更多","bottom_more")]
        
        for (index, vc) in viewControllersArray.enumerated() {
            vc.title = titlesArray[index].0
            vc.tabBarItem.title = titlesArray[index].0
            vc.tabBarItem.image = UIImage(named: titlesArray[index].1)
            vc.tabBarItem.selectedImage = UIImage(named: (titlesArray[index].1))
            
            let nav = UINavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }
}
