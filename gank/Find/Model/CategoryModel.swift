//
//  CategoryModel.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import Foundation
import UIKit

class CategoryModel:NSObject{
    var categoryName:String=""
    var categoryIcon:UIImage!
    var categoryColor:UIColor!

    init(name:String,icon:UIImage,color:UIColor) {
        categoryName=name
        categoryIcon=icon
        categoryColor=color
        super.init()
    }
}
