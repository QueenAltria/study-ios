//
//  LauncherViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/12.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class LauncherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //播放启动画面动画
        launchAnimation()
        print("启动界面")
    }
    
    func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 4, delay: 4.5, options: .beginFromCurrentState,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
    
    //获取启动图片名（根据设备方向和尺寸）
    func splashImageForOrientation(_ orientation: UIInterfaceOrientation, size: CGSize)
        -> String?{
            //获取设备尺寸和方向
            var viewSize = size
            var viewOrientation = "Portrait"
            
            if UIInterfaceOrientationIsLandscape(orientation) {
                viewSize = CGSize(width: size.height, height: size.width)
                viewOrientation = "Landscape"
            }
            
            //遍历资源库中的所有启动图片，找出符合条件的
            if let imagesDict = Bundle.main.infoDictionary  {
                if let imagesArray = imagesDict["UILaunchImages"] as? [[String: String]] {
                    for dict in imagesArray {
                        if let sizeString = dict["UILaunchImageSize"],
                            let imageOrientation = dict["UILaunchImageOrientation"] {
                            let imageSize = CGSizeFromString(sizeString)
                            if imageSize.equalTo(viewSize)
                                && viewOrientation == imageOrientation {
                                if let imageName = dict["UILaunchImageName"] {
                                    return imageName
                                }
                            }
                        }
                    }
                }
            }
            
            return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
