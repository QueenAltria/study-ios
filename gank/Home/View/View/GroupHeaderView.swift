//
//  GroupHeaderView.swift
//  gank
//
//  Created by wangxl on 2018/7/4.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class GroupHeaderView: UIView {
    
    var colorDic:[String:UIColor]=[String:UIColor]()
    var iconDic:[String:UIImage]=[String:UIImage]()
    
    var bgView:UIView=UIView()
    var imageRes:UIImageView=UIImageView()
    var titleLabel:UILabel=UILabel()
    
    var titleText:String="Android"
    
    func updateUI(){
        titleLabel.text=titleText
        bgView.backgroundColor=colorDic[titleText]
        imageRes.image=iconDic[titleText]
    }
    
    
    convenience init(param: String, frame: CGRect) {
        self.init(frame: frame)
        self.titleText = param
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.groupTableViewBackground
        self.frame=CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
        
        colorDic["Android"]=UIColor.init(r: 141, g: 192, b: 89)
        colorDic["iOS"]=UIColor.black
        colorDic["休息视频"]=UIColor.colorWithHexString("#9370db")
        colorDic["前端"]=UIColor.init(r: 51, g: 154, b: 237)
        colorDic["拓展资源"]=UIColor.colorWithHexString("#00ced1")
        colorDic["福利"]=UIColor.colorWithHexString("##ffb6c1")
        colorDic["瞎推荐"]=UIColor.colorWithHexString("#ffa500")
        colorDic["App"]=UIColor.init(r: 249, g: 89, b: 58)
        
        iconDic["Android"]=UIImage(named: "android")
        iconDic["iOS"]=UIImage(named: "ios")
        iconDic["休息视频"]=UIImage(named: "video")
        iconDic["前端"]=UIImage(named: "chrome")
        iconDic["拓展资源"]=UIImage(named: "ziyuan")
        iconDic["福利"]=UIImage(named: "images")
        iconDic["瞎推荐"]=UIImage(named: "tuijian")
        iconDic["App"]=UIImage(named: "app")
        
        setupUI()
    }
    
    func setupUI() {
        bgView=UIView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        bgView.backgroundColor=colorDic[titleText]
        bgView.layer.cornerRadius=15
        //bgView.layer.masksToBounds=true
        self.addSubview(bgView)
        
        imageRes=UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        imageRes.image=iconDic[titleText]
        imageRes.center=bgView.center
        self.addSubview(imageRes)
        
        titleLabel=UILabel()
        titleLabel.text=titleText
        titleLabel.textColor=normalColor
        self.addSubview(titleLabel)
        
//        bgView.snp.makeConstraints { (make) in
//            make.centerY.equalTo(self.snp.centerY)
//            //make.left.equalTo(-20)
//
//        }

        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
