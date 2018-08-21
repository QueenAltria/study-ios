//
//  GankData.swift
//  gank
//
//  Created by wangxl on 2018/6/27.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import SwiftyJSON

class GankModel:NSObject{
    
    /**
    "_id":"5b31adc3421aa9556b44c674",
    "createdAt":"2018-06-26T11:06:43.634Z",
    "desc":"正在开发的全新 V2ray.Fun。",
    "images":[
    "http://img.gank.io/06f73fc5-a34a-44d8-87af-cf2bc4a03d91",
    "http://img.gank.io/28c0ca0b-5132-47d5-a33c-0f9c46a3ab96"
    ],
    "publishedAt":"2018-06-27T00:00:00.0Z",
    "source":"chrome",
    "type":"App",
    "url":"https://github.com/FunctionClub/V2ray.Fun",
    "used":true,
    "who":"lijinshanmx"
     **/
    
    
    var _id:String? = ""; //id
    var createdAt:String? = ""; //创建日期
    var desc:String? = "" //描述
    var publishedAt:String? = ""
    var source:String? = ""
    var type:String? = ""
    var url:String? = ""
    var used:Bool? = true
    var who:String? = ""
    var images:[String]? = nil
    var ganhuo_id:String=""
    var content:String=""
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        _id = jsonData["_id"].stringValue
        createdAt = jsonData["createdAt"].stringValue
        desc = jsonData["desc"].stringValue
        publishedAt = jsonData["publishedAt"].stringValue
        source = jsonData["source"].stringValue
        type = jsonData["type"].stringValue
        url=jsonData["url"].stringValue
        used=jsonData["used"].boolValue
        who=jsonData["who"].stringValue
        images=jsonData["images"].arrayObject as? [String]
        ganhuo_id=jsonData["ganhuo_id"].stringValue
        content=jsonData["content"].stringValue
    }
}

class Gank{
    var category:[String]?
    var error:Bool
    //var results:[String:[GankModel]]=[String:[GankModel]]()
    var results:[GankResult]=[GankResult]()
    
    init(jsonData:JSON) {
        category=jsonData["category"].arrayObject as? [String]
        error=jsonData["error"].boolValue
        //results=jsonData["results"].dictionaryObject as! [String : [GankModel]]
    
        for (key,subJson):(String, JSON) in jsonData["results"] {
            //print("key------:\(key)：subJson------:\(subJson)")
            
            var array:[GankModel]=[GankModel]()
            for (_,sub) in subJson{
                array.append(GankModel(jsonData: sub))
            }
            //results[key]=array
            var result=GankResult()
            result.type=key
            result.model=array
            results.append(result)
        }
    }
}

class GankResult{
    var type:String=""
    var model:[GankModel]=[GankModel]()
    
    init() {
        
    }
    
    init(type:String,model:[GankModel]) {
        self.type=type
        self.model=model
    }
}
