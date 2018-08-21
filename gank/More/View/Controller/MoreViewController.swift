//
//  MoreViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    let appdelegate = (UIApplication.shared.delegate  as! AppDelegate);

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.groupTableViewBackground
        
        self.edgesForExtendedLayout=UIRectEdge()
        
        let scrollView=UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        scrollView.contentSize=CGSize(width: kScreenWidth, height: kScreenHeight+20)
        self.view.addSubview(scrollView)
        
        
        let headView=MoreHeadView()
        scrollView.addSubview(headView)
        
        
        let qqView=UIView(frame: CGRect(x: 0, y: headView.bounds.height+15, width: kScreenWidth, height: 50))
        qqView.backgroundColor=UIColor.white
        
        var qqLabel:UIButton=UIButton(frame: qqView.bounds)
        qqLabel.setTitle("QQ登录测试", for: UIControlState.normal)
        qqLabel.setTitleColor(UIColor.black, for: UIControlState.normal)
        qqLabel.contentHorizontalAlignment = .left
        qqLabel.backgroundColor=UIColor.white
        qqLabel.contentEdgeInsets=UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        scrollView.addSubview(qqLabel)
        
        qqLabel.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(50)
            make.top.equalTo(headView.snp.bottom).offset(15)
            //make.edges.equalTo(qqView)
            //make.left.equalTo(15)
        }
        
        
        let demoLabel:UIButton=UIButton(frame: qqView.bounds)
        demoLabel.setTitle("AwesomeDemo", for: UIControlState.normal)
        demoLabel.setTitleColor(UIColor.black, for: UIControlState.normal)
        demoLabel.contentHorizontalAlignment = .left
        demoLabel.backgroundColor=UIColor.white
        demoLabel.contentEdgeInsets=UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        scrollView.addSubview(demoLabel)
        
        demoLabel.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(50)
            make.top.equalTo(qqLabel.snp.bottom).offset(15)
            //make.edges.equalTo(qqView)
            //make.left.equalTo(15)
        }

        /**
        scrollView.addSubview(qqView)
        qqView.snp.makeConstraints { (make) in
            print("headViewHeight:\(headView.bounds.height)")
            debugPrint("headViewHeight:\(headView.bounds.height)")
            //make.top.equalTo(headView.bounds.height)
            //make.edges.equalTo(headView)   //edges 边缘相等
        }
         **/
        
        qqLabel.addTarget(self, action: "qqLogin", for: UIControlEvents.touchUpInside)
        demoLabel.addTarget(self, action: "push", for: UIControlEvents.touchUpInside)
    }
    
    @objc func push(){
        let vc=AwesomeViewController()
        vc.hidesBottomBarWhenPushed=true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func qqLogin(){
        let tencentOAuth=appdelegate.tencentOAuth
        //设置权限列表
        let permissions = ["get_user_info","get_simple_userinfo"];
        //登录
        tencentOAuth?.authorize(permissions)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
