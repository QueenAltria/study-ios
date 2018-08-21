//
//  BezierViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/21.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class BezierViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white

        var bezierText = BezierText(frame: CGRect(x: 0, y: 160,width: self.view.bounds.width, height: 50))
        self.view.addSubview(bezierText)
        
        bezierText.show(text: "Loading...")
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
