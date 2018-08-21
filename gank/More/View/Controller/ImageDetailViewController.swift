//
//  ImageDetailViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import Photos

class ImageDetailViewController: UIViewController {
    
    //选中的图片资源
    var myAsset:PHAsset!
    //用于显示图片信息
    var imageInfo:UILabel?
    //用于显示图片
    var imageView:UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white

        imageView=UIImageView(frame: CGRect(x: 0, y: kScreenHeight/3, width: kScreenWidth, height: kScreenHeight/3*2))
        self.view.addSubview(imageView!)
        
        imageInfo=UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight/3))
        imageInfo?.numberOfLines=0
        self.view.addSubview(imageInfo!)
        
        //获取文件名
        PHImageManager.default().requestImageData(for: myAsset, options: nil,
                                                  resultHandler: {
                                                    _, _, _, info in
                                                    self.title = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent
        })
        
        //获取图片信息
        imageInfo?.text = "日期：\(myAsset.creationDate!)\n"
            + "类型：\(myAsset.mediaType.rawValue)\n"
            + "位置：\(myAsset.location)\n"
            + "时长：\(myAsset.duration)\n"
        
        //获取原图
        PHImageManager.default().requestImage(for: myAsset,
                                              targetSize: PHImageManagerMaximumSize , contentMode: . default,
                                              options: nil, resultHandler: {
                                                (image, _: [AnyHashable : Any]?) in
                                                self.imageView?.image = image
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
