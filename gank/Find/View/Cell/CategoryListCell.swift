//
//  CategoryListCell.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class CategoryListCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var model:CategoryModel?{
        didSet{
            categoryLabel.text=model?.categoryName
            bgView.backgroundColor=model?.categoryColor
            iconImage.image=model?.categoryIcon
            
            bgView.layer.cornerRadius=25
            bgView.snp.makeConstraints { (make) in
                make.width.height.equalTo(50)
                make.centerX.equalTo(self.snp.centerX)
                make.top.equalTo(15)
            }
            
            iconImage.snp.makeConstraints { (make) in
                make.center.equalTo(bgView.snp.center)
            }
            
            categoryLabel.snp.makeConstraints { (make) in
                make.top.equalTo(bgView.snp.bottom).offset(10)
                make.centerX.equalTo(self.snp.centerX)
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
