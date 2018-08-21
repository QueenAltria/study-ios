//
//  RefreshCollectionDelegate.swift
//  gank
//
//  Created by wangxl on 2018/7/11.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

class RefreshCt:NSObject{
    
    var reDelagate:RefreshCollectioDelegate?
    
    static let instance: RefreshCt = RefreshCt()
    class func share() -> RefreshCt {
        return instance
    }
    
    func letRefresh(){
        reDelagate?.reload()
    }
}

protocol RefreshCollectioDelegate {
    func reload()
}
