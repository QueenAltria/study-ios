//
//  DateViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/16.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import WebKit

class DateViewController: UIViewController {
    
    var webView:WKWebView?
    var backgroundView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNet()
    }
    
    func setupUI() {
        navigationItem.title="网站数据"
        
        let right=UIBarButtonItem(title: "日期", style: UIBarButtonItemStyle.plain, target: self, action: "date")
        self.navigationItem.rightBarButtonItem=right
        
        self.view.backgroundColor=UIColor.white
        webView=WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView!)
        
        backgroundView=UIView(frame: self.view.bounds)
        backgroundView?.backgroundColor=UIColor.colorWithHexString("000000", alpha: 0.3)
        backgroundView?.isHidden=true
        
        self.view.addSubview(backgroundView!)
        
        backgroundView?.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        tapGesture.numberOfTapsRequired = 1
        backgroundView?.addGestureRecognizer(tapGesture)
    }
    
    @objc func close(){
        backgroundView?.isHidden=true
    }
    
    
    @objc func picker(){
    
    }
    
    @objc func date(){
        let datePicker = UIDatePicker(frame: CGRect(x:0, y:0, width:500, height:216))
        datePicker.datePickerMode=UIDatePickerMode.date
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action:#selector(dateChanged),for: .valueChanged)
        
        
        let dateformatter=DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        let minDate = dateformatter.date(from: "2015-05-18")
        datePicker.minimumDate=minDate
        datePicker.maximumDate = Date() //当前时间
        
        datePicker.frame=CGRect(x: 0, y: 0, width: 270, height: 200)   //需要设置一个frame才能正常显示
        
        //self.view.addSubview(datePicker)
        
//        datePicker.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self.view.snp.bottom)
//            make.width.equalTo(self.view.snp.width)
//        }
        
        
        backgroundView?.isHidden=false
        
        
        let alert = UIAlertController(title: "选择日期", message: nil, preferredStyle: .alert)
        //alert.setValue(datePicker, forKey: "accessoryView")
        alert.view.addSubview(datePicker)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true)
        
        
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        // setting properties of the datePicker
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)    //需要设置一个frame才能正常显示
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        //self.present(alertController, animated: true, completion:{})

    }
    
    @objc func dateChanged(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DateViewController{
    func loadNet(){
        
        let categoryUrl=URL_main+"history/content/day/2018/03/13"
        
        print("url:\(categoryUrl)")
        QMNetworkToolsJson.requestData(.get, URLString: categoryUrl) { (resultJson) in
            
            if !resultJson["error"].boolValue{
                //print("请求成功\(resultJson)")
                
                var content=resultJson["results"][0]["content"].stringValue
                print(content)
                self.webView?.loadHTMLString(content, baseURL: nil)
            }
        }
    }
}

