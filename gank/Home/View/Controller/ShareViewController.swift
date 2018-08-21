//
//  ShareViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/10.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label=UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        label.text="接收分享内容"
        label.center=self.view.center
        label.textAlignment=NSTextAlignment.center
        self.view.addSubview(label)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
