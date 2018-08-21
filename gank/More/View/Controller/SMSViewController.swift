//
//  SMSViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import MessageUI

class SMSViewController: UIViewController,UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white

        //首先判断设备具不具备发送短信功能
        if MFMessageComposeViewController.canSendText(){
            let controller=MFMessageComposeViewController()
            //设置短信内容
            controller.body="短信内容"
            //设置收件人列表
            controller.recipients=["10086","10011"]
            //设置代理
            controller.messageComposeDelegate=self
            //打开界面
            self.present(controller, animated: true) {
                
            }
        }else{
            debugPrint("本设备不能发送短信")
            let empty=EmptyView(frame: self.view.bounds)
            empty.setEmpty(title: "本设备不能发送短信", image: UIImage(named: "s"))
            self.view.addSubview(empty)
            
        }
    }
    
    //发送短信代理
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result.rawValue {
        case MessageComposeResult.sent.rawValue:
            print("短信已发送")
        case MessageComposeResult.cancelled.rawValue:
            print("短信取消发送")
        case MessageComposeResult.failed.rawValue:
            print("短信发送失败")
        default:
            break
        }
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
