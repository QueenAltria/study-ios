//
//  RandomHeaderView.swift
//  gank
//
//  Created by wangxl on 2018/7/10.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class RandomHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.groupTableViewBackground
        self.frame=CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
        setupUI()
    }
    
    func setupUI(){
        let image=UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        image.image=UIImage(named: "random")
        image.image?.withRenderingMode(UIImageRenderingMode.automatic)
        image.tintColor=UIColor.black
        
        self.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(15)
        }
        
        let label=UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        label.text="随机干货"
        label.textColor=UIColor.colorWithHexString("#cccccc")
        label.font=UIFont.systemFont(ofSize: 14)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(image.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
