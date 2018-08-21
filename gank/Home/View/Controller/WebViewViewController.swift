//
//  WebViewViewController.swift
//  gank
//
//  Created by wangxl on 2018/7/5.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class WebViewViewController: UIViewController {
    
    var urlString:String?
    var intentModel:GankModel?
    var webView=WKWebView()
    var progressBar:UIProgressView!
    
    let refresh:RefreshCollectioDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){

        let barButtonItem = UIBarButtonItem(title: "操作", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showRank))
        self.navigationItem.rightBarButtonItem = barButtonItem   //添加一个右部按钮
        
        //self.edgesForExtendedLayout=UIRectEdge()
        self.view.backgroundColor=UIColor.white
        webView=WKWebView(frame: self.view.bounds)
        webView.load(URLRequest(url: URL(string: urlString!)!))
        webView.uiDelegate=self
        webView.navigationDelegate=self
        self.view.addSubview(webView)
        
        print("webUrl:\(urlString)")
        
        progressBar=UIProgressView(frame: CGRect(x: 0, y: 60, width: kScreenWidth, height: 2))
        progressBar.tintColor=normalColor
        progressBar.progress=0.0
        self.view.addSubview(progressBar)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressBar.alpha = 1.0
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(self.webView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.progressBar.alpha=0.0
                }) { (finished) in
                    self.progressBar.progress=0
                }
            }
        }else if keyPath == "title"{
            navigationItem.title=webView.title
        }
    }
    
    //移除监听
    deinit {
        print("con is deinit")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        self.progressBar.reloadInputViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showRank(){
        print("点击操作")
        // 建立一個提示框
        let alertController = UIAlertController(title: "底部提示",message: "请选择操作",preferredStyle: .actionSheet)
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(title: "取消",style: .cancel,handler: nil)
        alertController.addAction(cancelAction)
    
        let colAction = UIAlertAction(title: "收藏",style: .default,handler: { (_) in
            print("点击收藏")
            
            let tip=MBProgressHUD.showAdded(to: self.view, animated: true)
            tip.mode = MBProgressHUDMode.text
            tip.label.text="已收藏"
            tip.contentColor=UIColor.white   //文字的颜色
            tip.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
            tip.bezelView.backgroundColor=UIColor.black
            tip.offset=CGPoint(x: 0, y: 150)
            tip.hide(animated: true, afterDelay: 1)
            
            SqlManager.shared.insert(model: self.intentModel!)
            RefreshCt.share().letRefresh()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)

        })
        alertController.addAction(colAction)
        
        let copyAction = UIAlertAction(title: "复制链接",style: .default,handler: { (_) in
            self.wishSeed()
        })
        alertController.addAction(copyAction)
        
        let openAction = UIAlertAction(title: "在浏览器中打开",style: .default,handler: { (_)in
            self.openInOpera()
        })
        alertController.addAction(openAction)
        
        let shareAction = UIAlertAction(title: "分享",style: .default,handler: {(_) in
            self.share()
        })
        alertController.addAction(shareAction)
        
        let lookAction = UIAlertAction(title: "查看文章标题",style: .default,handler: {(_) in
            UIAlertController.showAlert(message: self.urlString!)
        })
        alertController.addAction(lookAction)
        
        // 建立[確認]按鈕
        let refreshAction = UIAlertAction(title: "刷新",style: .default,handler: {(_) in
            self.webView.reload()
        })
        alertController.addAction(refreshAction)
        
        //alertController
        
        // 顯示提示框
        self.present(alertController,animated: true,completion: nil)
    }
    
    //复制到剪切板
    func wishSeed() {
        let pas = UIPasteboard.general
        pas.string = urlString
    }
    
    //在浏览器中打开
    func openInOpera(){
        if let url = URL(string: self.urlString!) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {(success) in})
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //分享
    func share() {
        //准备分享内容，文本图片链接
        let items:[Any] = ["分享链接", UIImage.init(named: "icon-72"),URL(fileURLWithPath:urlString!)]
        //根据分享内容和自定义的分享按钮调用分享视图
        let actView:UIActivityViewController =
            UIActivityViewController(activityItems: items, applicationActivities: [ReceiveUIActivity()])
        //要排除的分享按钮，不显示在分享框里
        actView.excludedActivityTypes = [.mail,.copyToPasteboard,.print,.assignToContact,.saveToCameraRoll]
        //显示分享视图
        self.present(actView, animated:true, completion:nil)
        //对分享结果监听
        actView.completionWithItemsHandler = {(_ activityType: UIActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ activityError: Error?) -> Void in
            print(completed ? "成功" : "失败")
        }
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

extension WebViewViewController:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完毕")
    }
}
