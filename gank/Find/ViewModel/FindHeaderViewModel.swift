//
//  FindHeaderViewModel.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

class FindHeaderViewModel {
    
    var categoryArray:[CategoryModel]=[CategoryModel]()
    var gankArray=[GankModel]()
    var currentArray:[GankModel]?
    
    func loadData(completeBlock: @escaping() -> ()) {
        let categoryUrl=URL_main+RANDOM
        print("请求URL:\(categoryUrl)")
        
        QMNetworkToolsJson.requestData(.get, URLString: categoryUrl) { (resultJson) in
            
            if !resultJson["error"].boolValue{
                //print("请求成功\(resultJson)")
                
                self.currentArray=[GankModel]()
                for jsonItem in resultJson["results"].arrayValue{
                    let gankItem:GankModel=GankModel(jsonData: jsonItem)
                    
                    self.gankArray.append(gankItem)
                    self.currentArray?.append(gankItem)
                }
                
                completeBlock()
            }
        }
    }
    
    init() {
        
        let cm_android=CategoryModel(name: "Android", icon: UIImage(named: "android")!, color: UIColor.init(r: 141, g: 192, b: 89))
        
        let cm_ios=CategoryModel(name: "iOS", icon: UIImage(named: "ios")!, color: UIColor.black)
        
        let cm_video=CategoryModel(name: "休息视频", icon: UIImage(named: "video")!, color: UIColor.colorWithHexString("#9370db"))
        
        let cm_chrome=CategoryModel(name: "前端", icon: UIImage(named: "chrome")!, color: UIColor.init(r: 51, g: 154, b: 237))
        
        let cm_app=CategoryModel(name: "App", icon: UIImage(named: "app")!, color: UIColor.init(r: 249, g: 89, b: 58))
        
        let cm_ziyuan=CategoryModel(name: "拓展资源", icon: UIImage(named: "ziyuan")!, color: UIColor.colorWithHexString("#00ced1"))
        
        let cm_random=CategoryModel(name: "瞎推荐", icon: UIImage(named: "tuijian")!, color: UIColor.colorWithHexString("#ffa500"))
        
        let cm_images=CategoryModel(name: "福利", icon: UIImage(named: "images")!, color: UIColor.colorWithHexString("#ffb6c1"))
        
        
        categoryArray.append(cm_android)
        categoryArray.append(cm_ios)
        categoryArray.append(cm_chrome)
        categoryArray.append(cm_app)
        categoryArray.append(cm_video)
        categoryArray.append(cm_ziyuan)
        categoryArray.append(cm_random)
        categoryArray.append(cm_images)
    }
}
