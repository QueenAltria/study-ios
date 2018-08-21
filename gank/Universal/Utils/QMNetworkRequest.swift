//
//  QMNetworkRequest.swift
//  PatternBusiness
//
//  Created by 乔木 on 2018/5/30.
//  Copyright © 2018年 乔木. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MethodType {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
}

class NetworkTools {
    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
            
            guard case let .failure(error) = response.result else { return }
            
            if let error = error as? AFError {
                switch error {
                case .invalidURL(let url):
                    print("无效 URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("参数编码失败: \(error.localizedDescription)")
                    print("失败理由: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding 失败: \(error.localizedDescription)")
                    print("失败理由: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response 校验失败: \(error.localizedDescription)")
                    print("失败理由: \(reason)")
                default:
                    print("default")
                    
                }
                
            }
            
        }
    }
}

class QMNetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : NSDictionary) -> ()) {
        //1.判断类型
       let method = type == .get ? HTTPMethod.get : HTTPMethod.post
            // 2.发送网络请求
            Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
                // 3.获取结果(Data)
                guard let result = response.data else {
                    print(response.result.error!)
                    return
                }
                //4.类型转换
                let dict : NSDictionary = try! JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                // 5.将结果回调出去
                finishedCallback(dict)
            }
    }
}

class QMNetworkToolsJson {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : JSON) -> ()) {
        //1.判断类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果(Data)
            guard let result = response.data else {
                print(response.result.error!)
                return
            }
            //4.类型转换
            //                let dict : NSDictionary = try! JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            // 5.将结果回调出去
            finishedCallback(JSON(result))
        }
    }
}
 
