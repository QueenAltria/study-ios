//
//  CollectionReusableViewHeader.swift
//  gank
//
//  Created by wangxl on 2018/7/10.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

let headerIdentifier = "CollectionReusableViewHeader"

class CollectionReusableViewHeader: UICollectionReusableView {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
