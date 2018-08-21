//
//  DynamicsViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class DynamicsViewController: UIViewController {
    var dynamicAnimator=UIDynamicAnimator()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        
        
        let imageView=UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image=UIImage(named: "bottom_collection")
        imageView.isUserInteractionEnabled=true
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        dynamicAnimator=UIDynamicAnimator(referenceView: self.view)
    
        //创建并添加重力行为
        let gravityBehavior = UIGravityBehavior(items: [imageView])
        dynamicAnimator.addBehavior(gravityBehavior)
        
        //创建并添加碰撞行为
        let collisionBehavior = UICollisionBehavior(items: [imageView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
 
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
