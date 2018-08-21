//
//  CategoryViewCell.swift
//  gank
//
//  Created by wangxl on 2018/7/6.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import Kingfisher
//TODO 加载GIF的内存占用问题

class CategoryViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var preImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var model:GankModel?{
        didSet{
            preImage.image=UIImage()
            preImage.snp.makeConstraints { (make) in
                make.width.height.equalTo(80)
            }
            
            let path = Bundle.main.path(forResource: "ac", ofType: "gif")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            //preImage.kf.indicatorType = .image(imageData: data)
            preImage.kf.indicatorType = .activity
            
            let images=model?.images
            var imageUrl="http://www.baidu.com"
            if images != nil{
                if (images?.count)!>0{
                    //imageUrl=images![0]
                }
            }
            let link=URL(string:imageUrl)
            
            let gifUrl = Bundle.main.url(forResource: "ac", withExtension:"gif") as! Resource
            
            preImage.kf.setImage(with: link)
            
            preImage.kf.setImage(with: link, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageUrl) in
                //image       // 为 nil 时，表示下载失败
                //error       // 为 nil 时，表示下载成功， 非 nil 时，就是下载失败的错误信息
                //cacheType   // 缓存类型，是个枚举，分以下三种：
                // .none    图片还没缓存（也就是第一次加载图片的时候）
                // .memory  从内存中获取到的缓存图片（第二次及以上加载）
                // .disk    从磁盘中获取到的缓存图片（第二次及以上加载）
                //imageUrl    // 所要下载的图片的url
                
                if(error==nil){
                    //print("图片下载成功")
                }else{
                    self.preImage.kf.setImage(with: gifUrl)
                    //print("图片下载失败\(error)")
                }
            }
        
            titleLabel.text=model?.desc
            
            setText(label: categoryLabel, str: (model?.type)!, imageNamed: "tag")
            setText(label: authorLabel, str: (model?.who)!, imageNamed: "edit")
            setText(label: dateLabel, str: (model?.publishedAt?.subString(start: 0, length: 10))!, imageNamed: "date")
        }
    }
    
    func setText(label:UILabel,str:String,imageNamed:String){
        // 创建1个属性字符串
        let  attrStr = NSAttributedString(string: str)
        // 图文混排
        let attacment = NSTextAttachment()
        attacment.image = UIImage(named: imageNamed)   // 设置要显示的图片
        let font = label.font              // 取出demoLabel控制文字大小
        attacment.bounds = CGRect(x: 0, y: -4, width: (font?.lineHeight)!, height: (font?.lineHeight)!)
        let attrImageStr = NSAttributedString(attachment: attacment)  // 设置图片显示的大小及位置
        // 拼接图文
        let attrMStr = NSMutableAttributedString()
        attrMStr.append(attrImageStr)
        attrMStr.append(attrStr)
        // 显示属性字符串
        label.attributedText = attrMStr
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
