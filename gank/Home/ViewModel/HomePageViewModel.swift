//
//  HomePageViewModel.swift
//  gank
//
//  Created by wangxl on 2018/7/4.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation

class HomePageViewModel:NSObject{
    
    var fuliItem:GankModel!
    var homeArray:[GankResult]=[GankResult]()
    
    func loadHomePageData(completeBlock: @escaping() -> ()) {
        
        
        let historyUrl=URL_main+GET_HISTORY
        
        QMNetworkToolsJson.requestData(.get, URLString: historyUrl) { (resultJson) in
            
            if !resultJson["error"].boolValue{
                var date=resultJson["results"].arrayValue[0].stringValue.replacingOccurrences(of: "-", with: "/")
                print("date:\(date)")
                
                
                let url:String = URL_main+GET_DATA_BY_DAY+date
                print(url)
                
                QMNetworkToolsJson.requestData(.get, URLString: url) { (resultJson) in
                    
                    let gank=Gank(jsonData: resultJson)
                    
                    if !gank.error{
                        print("请求成功")
                        
                        for str in gank.category!{
                            //print(str)
                        }
                        
                        
                    
                        if gank.results.count>0{
                            for (index,item) in gank.results.enumerated(){
                                if item.type=="福利"{
                                    self.fuliItem=item.model[0]
                                    gank.results.remove(at: index)
                                    break
                                }
                            }
                        }
                        
                        
                        self.homeArray=gank.results
                        
                    
                        
                        print("gank.results.count\(gank.results.count)")
                        
                        
                        completeBlock()
                        
                    }
                    //print(resultJson)
                }
            }
        }
        
    }
    
   
}
