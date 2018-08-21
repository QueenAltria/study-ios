//
//  HomeListCell.swift
//  gank
//
//  Created by wangxl on 2018/7/4.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var whoimage: UIImageView!
    
    var model:GankModel?{
        didSet{
            authorName.text=model?.who
            title.text=model?.desc

            authorName.textColor=UIColor.colorWithHexString("#cccccc")
            title.textColor=UIColor.black
            
            //title.frame=CGRect.zero
            
            whoimage.snp.makeConstraints { (make) in
                make.width.height.equalTo(10)
                make.top.equalTo(20)
                make.left.equalTo(20)
            }
          

            authorName.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth-50)
                make.height.equalTo(15)
                make.centerY.equalTo(whoimage.snp.centerY)
                make.left.equalTo(32)
            }
            

            title.snp.makeConstraints { (make) in
                make.width.equalTo(kScreenWidth)
                make.height.lessThanOrEqualTo(1000)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(whoimage.snp.bottom).offset(10)
                make.bottom.equalTo(-10)  //在最后一个view一定要添加与底部的一个约束
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
