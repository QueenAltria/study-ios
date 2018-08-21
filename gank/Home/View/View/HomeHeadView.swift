//
//  HomeHeadView.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class HomeHeadView: UIView {
    
    let girlImg=UIImageView()
    var bottomView:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.groupTableViewBackground
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 460)
        setupUI()
    }
    
    var gankItem:GankModel!{
        didSet{
            let link=URL(string:gankItem.url!)
            //girlImg.kf.setImage(with: link)   //请求成功之后 设置头部图片
            
            print("首页图片URL\(gankItem.url!)")
            bottomView.text=(gankItem.publishedAt?.subString(start: 0, length: 10).replacingOccurrences(of: "-", with: "/"))!+"\t"
        }
    }
    
    func setupUI(){
        girlImg.frame=bounds
        let link=URL(string:"")
        girlImg.kf.setImage(with: link)
        girlImg.kf.indicatorType = .activity  //设置加载
        girlImg.kf.setImage(with: link, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
            //image       // 为 nil 时，表示下载失败
            //error       // 为 nil 时，表示下载成功， 非 nil 时，就是下载失败的错误信息
            //cacheType   // 缓存类型，是个枚举，分以下三种：
            // .none    图片还没缓存（也就是第一次加载图片的时候）
            // .memory  从内存中获取到的缓存图片（第二次及以上加载）
            // .disk    从磁盘中获取到的缓存图片（第二次及以上加载）
            //imageUrl    // 所要下载的图片的url
            
            if(error==nil){
                print("图片下载成功")
            }else{
                self.girlImg.image=UIImage(named: "feiniao")
                print("图片下载失败\(error)")
            }
        }
        
        girlImg.clipsToBounds=true   //图片超出的部分不显示在屏幕上
        girlImg.contentMode=UIViewContentMode.scaleAspectFill
        self.addSubview(girlImg)
        
        
        //创建一个模糊效果
        let blurEffect=UIBlurEffect(style: .dark)
        let blurView=UIVisualEffectView(effect: blurEffect)
        //设置模糊大小视图大小
        blurView.frame.size = CGSize(width: kScreenWidth, height: 50)
        blurView.alpha=0.9
        //添加模糊视图
        girlImg.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.bottom.equalTo(girlImg.snp.bottom)
            make.left.equalTo(girlImg)
            make.right.equalTo(girlImg)
            make.height.equalTo(50)
        }
        
        bottomView=UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        //bottomView.text="2018/07/03\t"
        bottomView.font=UIFont(name: "HelveticaNeue-Bold", size: 25)
        bottomView.textColor=UIColor.white
        bottomView.textAlignment = .right
        girlImg.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { (make) in
            make.edges.equalTo(blurView)
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
