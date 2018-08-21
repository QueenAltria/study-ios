//
//  CategoryListModel.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class CategoryListModel:NSObject{
    var gankArray=[GankModel]()
    var currentArray:[GankModel]?
    var category:String?
    var pageSize:String?
    
    init(category:String,pageSize:Int) {
        self.category=category
        self.pageSize="\(pageSize)"
    }
    
    func loadData(completeBlock: @escaping() -> ()) {
    
        let encodingCategory=category?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  //需要把中文重新编码
        
        let categoryUrl=URL_main+GET_CATEGORY_DATA+encodingCategory!+PAGE_NUM+pageSize!
        print("请求URL:、\(categoryUrl)")
        
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
}
