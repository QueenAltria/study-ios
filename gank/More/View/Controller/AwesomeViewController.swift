//
//  AwesomeViewController.swift
//  gank
//
//  Created by wangxl on 2018/8/20.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import ContactsUI
import PhotosUI

class AwesomeViewController: UIViewController,CNContactPickerDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var strArray=["使用ContactsUI访问通讯录","使用Contact纯代码获取联系人","短信发送","拨打电话",
                "发送本地通知,更改角标","使用UIDynamics添加重力行为","相册","系统相册","跳转AppStore","获取设备信息",
                "自动书写文字"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView=UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        tableView.delegate=self
        tableView.dataSource=self
        tableView.tableFooterView=UIView()
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AwesomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text=strArray[indexPath.row]
        cell.textLabel?.font=UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击效果  
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            //联系人选择控制器
            let contactPicker = CNContactPickerViewController()
            //设置代理
            contactPicker.delegate = self
            //添加可选项目的过滤条件
            contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0", argumentArray: nil)
            //弹出控制器
            self.present(contactPicker, animated: true, completion: nil)
        }else if indexPath.row == 1{
            let vc=CodeContactsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc=SMSViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            //打开拨号界面并拨打电话
            let urlString="tel://10086"
            if let url = URL(string: urlString){
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *){
                    UIApplication.shared.open(url, options: [ : ]) { (success) in
                        
                    }
                }else{
                    UIApplication.shared.openURL(url)
                }
            }
        }else if indexPath.row == 4{
            //清除所有本地推送
            UIApplication.shared.cancelAllLocalNotifications()
            //进行本地推送
            let localNotification=UILocalNotification()
            //设置右上角提醒格式
            localNotification.applicationIconBadgeNumber=66
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }else if indexPath.row == 5{
            let vc=DynamicsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6{
            
            let layout = UICollectionViewFlowLayout.init()
            layout.itemSize = CGSize(width: (kScreenWidth-10)/4, height: (kScreenWidth-10)/4)
            layout.minimumLineSpacing=0.0
            layout.minimumInteritemSpacing=0.0
            layout.sectionInset = UIEdgeInsetsMake(0, 0.0, 0, 0.0)
            let vc=PhotoViewController.init(collectionViewLayout: layout)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7{
            let pick:UIImagePickerController = UIImagePickerController()
            pick.delegate = self
            self.present(pick, animated: true) {
                
            }
        }else if indexPath.row == 8{
            gotoAppStore()
        }else if indexPath.row == 9{
            getDeviceInfo()
        }else if indexPath.row == 10{
            let vc=BezierViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //单选联系人
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        //获取联系人的姓名
        let lastName = contact.familyName
        let firstName = contact.givenName
        print("选中人的姓：\(lastName)")
        print("选中人的名：\(firstName)")
        
        //获取联系人电话号码
        print("选中人电话：")
        let phones = contact.phoneNumbers
        for phone in phones {
            //获得标签名（转为能看得懂的本地标签名，比如work、home）
            let phoneLabel = CNLabeledValue<NSString>.localizedString(forLabel: phone.label!)
            //获取号码
            let phoneValue = phone.value.stringValue
            print("\(phoneLabel):\(phoneValue)")
        }
    }
    
    //系统相册
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /**
        var imageview:UIImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 300, height: 300))
        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageview.image = gotImage
        self.view.addSubview(imageview)
         **/
        print(info);
        self.dismiss(animated: true, completion: nil)
    }
    
    //跳转到应用的AppStore页页面
    func gotoAppStore() {
        let urlString = "itms-apps://itunes.apple.com/app/id444934666"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //获取设备信息
    func getDeviceInfo() {
        //应用程序信息
        let infoDictionary = Bundle.main.infoDictionary!
        let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
        let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
        let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
        let appVersion = majorVersion as! String
        
        //设备信息
        let iosVersion = UIDevice.current.systemVersion //iOS版本
        let identifierNumber = UIDevice.current.identifierForVendor //设备udid
        let systemName = UIDevice.current.systemName //设备名称
        let model = UIDevice.current.model //设备型号
        let modelName = UIDevice.current.modelName //设备具体型号
        let localizedModel = UIDevice.current.localizedModel //设备区域化型号如A1533
        
        //打印信息
        print("程序名称：\(appDisplayName)")
        print("主程序版本号：\(appVersion)")
        print("内部版本号：\(minorVersion)")
        print("iOS版本：\(iosVersion)")
        print("设备udid：\(identifierNumber)")
        print("设备名称：\(systemName)")
        print("设备型号：\(model)")
        print("设备具体型号：\(modelName)")
        print("设备区域化型号：\(localizedModel)")
    }
}
