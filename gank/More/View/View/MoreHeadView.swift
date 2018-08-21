//
//  MoreHeadView.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class MoreHeadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.white
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 180)
        setupUI()
    }

    func setupUI(){
        let bgImage=UIImageView()
        bgImage.frame=bounds
        bgImage.image=UIImage(named: "feiniao")
        addSubview(bgImage)
        //创建一个模糊效果
        let blurEffect=UIBlurEffect(style: .light)
        let blurView=UIVisualEffectView(effect: blurEffect)
        //设置模糊大小视图大小
        //blurView.frame.size = CGSize(width: kScreenWidth, height: 180)
        blurView.frame=bounds
        //添加模糊视图
        bgImage.addSubview(blurView)
        
        //添加中间图片
        let imageView=UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.image=UIImage(named: "feiniao")
        imageView.contentMode=UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius=40
        imageView.center=self.center
        imageView.layer.masksToBounds=true
        imageView.frame.origin.y=imageView.frame.origin.y-20
        self.addSubview(imageView)
        
        //创建并添加vibrancy视图  一般和模糊一起使用
        let vibrancyView=UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.frame.size = CGSize(width: frame.width, height: frame.height)
        blurView.contentView.addSubview(vibrancyView)
        //添加一个标签
        let label=UILabel(frame: CGRect(x: 0, y: imageView.frame.origin.y+90,
                                        width: kScreenWidth, height: 30))
        label.text="Gank.io"
        label.font=UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textAlignment = .center
        label.textColor=UIColor.white
        vibrancyView.contentView.addSubview(label)
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
