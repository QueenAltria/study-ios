//
//  PhotoViewCell.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    
    var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView=UIImageView(frame: self.bounds)
        imageView?.tag=1
        self.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
