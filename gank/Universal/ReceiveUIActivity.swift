//
//  ReceiveUIActivity.swift
//  gank
//
//  Created by wangxl on 2018/7/9.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class ReceiveUIActivity: UIActivity {
    
    //用于保存传递过来的要分享的数据
    var text:String!
    var url:URL!
    var image:UIImage!
    
    //分享的标题
    override var activityTitle: String?{
        return "Gank.io"
    }
    
    //分享的logo
    override var activityImage: UIImage?{
        return UIImage(named: "icon-72")
    }
    
    //提供的服务类型的标识符
    override var activityType: UIActivityType?{
        return UIActivityType.init(ReceiveUIActivity.self.description())
    }
    
    //分享类型
    override class var activityCategory: UIActivityCategory {
        return .share
    }
    
    //此处对要分享的内容做操作
    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems{
            if item is String{
                text = item as! String
            }
            if item is URL{
                url = item as! URL
            }
            if item is UIImage{
                image = item as! UIImage
            }
        }
        
        for (index,item) in activityItems.enumerated(){
            print("\(index):\(item)")
        }
    }
    
    //此处预判断下，是否允许进行分享
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems{
            if item is UIImage{
                return true
            }
            if item is URL{
                return true
            }
            if item is String{
                return true
            }
        }
        return false
    }
    
    //执行分享行为
    override func perform() {
        activityDidFinish(true)
        
        let vc=ShareViewController()
        
    }
    
    //分享时调用
    override var activityViewController: UIViewController?{
        let vc=ShareViewController()
        return vc
    }
    
    //完成分享调用
    override func activityDidFinish(_ completed: Bool) {
        print("activityDidFinish")
    }
}
