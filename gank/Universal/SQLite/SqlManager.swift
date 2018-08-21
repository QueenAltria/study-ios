//
//  SqlManager.swift
//  gank
//
//  Created by wangxl on 2018/7/10.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import FMDB
import SwiftyJSON

class SqlManager:NSObject{
    static let shared:SqlManager=SqlManager()
    let databaseFileName="gank.sqlite"   //数据库名称
    var pathToDatabase:String!  //数据库路径
    var database:FMDatabase!   //数据库
    
    //static func 相当于class final func。禁止这个方法被重写   class func 静态方法
    class func shareManager() -> SqlManager {
        return shared
    }
    
    override init() {
        super.init()
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        print("数据库路径：、\(pathToDatabase)")
    }
    
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
    
    func createDatabase() -> Bool {
        var created=false
        if !FileManager.default.fileExists(atPath: pathToDatabase){
            database=FMDatabase(path: pathToDatabase!)  //创建数据库
            if database != nil{
                if database.open(){  //打开
                    let createSchedualTableQuery = "create table if not exists gank_table (_id TEXT primary key ,createdAt TEXT not null,desc TEXT not null,publishedAt TEXT ,source TEXT, type TEXT, url TEXT, used TEXT, who TEXT, images TEXT);"
                    database.executeStatements(createSchedualTableQuery)//建表
                    created = true
                    database.close()
                }else{
                    print("Could not open the database")
                }
            }
        }
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    
    //插入数据
    func insert(model:GankModel){
        let sql="INSERT INTO gank_table (_id,createdAt,desc,publishedAt,source,type,url,used,who,images) "+"VALUES (?,?,?,?,?,?,?,?,?,?)"
        database.open()
        
        let imageStr = model.images?.joined(separator: ",")
        
        database.executeUpdate(sql, withArgumentsIn: [model._id,model.createdAt,model.desc,model.publishedAt,model.source,
                                                           model.type,model.url,model.used,model.who,imageStr])
        database.close()
    }
    
    //更新数据
    func update(model:GankModel){
        let sql = "UPDATE gank_table SET _id=?,createdAt=?,desc=?,publishedAt=?,source=? ,type=?,url=?,used=?,who=?,images=?"
        database.open()
        database.executeUpdate(sql, withArgumentsIn: [model._id,model.createdAt,model.desc,model.publishedAt,model.source,
                                                      model.type,model.url,model.used,model.who,model.images])
        database.close()
    }
    
    //删除数据
    func remove(_id:String){
        let sql = "DELETE FROM gank_table WHERE _id = ?"
        database.open()
        database.executeUpdate(sql, withArgumentsIn: [_id])
        database.close()
    }
    
    //查询数据
    func select(_id:String)->GankModel?{
        
        let sql = "SELECT * FROM gank_table WHERE _id = ?"
        database.open()
        let rs = database.executeQuery(sql, withArgumentsIn: [_id])
        var model:GankModel?=GankModel()
        
        while (rs?.next())! {
            model?._id=rs?.string(forColumn: "_id")
            model?.createdAt=rs?.string(forColumn: "createdAt")
            model?.desc=rs?.string(forColumn: "desc")
            model?.publishedAt=rs?.string(forColumn: "publishedAt")
            model?.source=rs?.string(forColumn: "source")
            model?.type=rs?.string(forColumn: "type")
            model?.url=rs?.string(forColumn: "url")
            model?.used=rs?.bool(forColumn: "used")
            model?.who=rs?.string(forColumn: "who")
            //model?.images=rs?.string(forColumn: "images")
        }
        
        database.close()
        
        return model
    }
    
    func selectAll() -> [GankModel] {
        let sql = "SELECT * FROM gank_table"
        database.open()
        let rs = database.executeQuery(sql, withArgumentsIn: [])
        var modelArray=[GankModel]()
        
        while (rs?.next())! {
            let model=GankModel()
            
            model._id=rs?.string(forColumn: "_id")
            model.createdAt=rs?.string(forColumn: "createdAt")
            model.desc=rs?.string(forColumn: "desc")
            model.publishedAt=rs?.string(forColumn: "publishedAt")
            model.source=rs?.string(forColumn: "source")
            model.type=rs?.string(forColumn: "type")
            model.url=rs?.string(forColumn: "url")
            model.used=rs?.bool(forColumn: "used")
            model.who=rs?.string(forColumn: "who")
            //model.images=rs?.string(forColumn: "images")
            
            let str=rs?.string(forColumn: "images")
            model.images=str?.components(separatedBy: ",")
            
            //print("image路径：\(str)")
            
            modelArray.insert(model, at: 0)
            //modelArray.append(model)
        }
        
        database.close()
        
        return modelArray
    }
}
