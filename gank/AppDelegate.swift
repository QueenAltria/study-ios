//
//  AppDelegate.swift
//  gank
//
//  Created by wangxl on 2018/7/3.
//  Copyright © 2018年 JackYin. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,TencentSessionDelegate {

    var window: UIWindow?
    /** *控制屏幕旋转 */
    var allowRotation = Bool()
    
    var tencentOAuth:TencentOAuth!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        
        SqlManager.init()
        SqlManager.shared.createDatabase()
        SqlManager.shared.openDatabase()
        
        tencentOAuth = TencentOAuth.init(appId: "1106966601", andDelegate: self)
        
        //开启通知
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert, .carPlay]) { (success, error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        }else{
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                      categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotation {
            return .allButUpsideDown
        }
        return .portrait
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TencentOAuth.handleOpen(url)
    }
    
    func tencentDidLogin() {
        if !tencentOAuth.accessToken.isEmpty {
            print("----------------------------------------")
            print("登录成功！")
            print("openId：\(tencentOAuth.openId)",
                "accessToken：\(tencentOAuth.accessToken)",
                "expirationDate：\(tencentOAuth.expirationDate)")
            print("开始获取用户资料")
            tencentOAuth.getUserInfo()
        }else {
            print("登录失败！没有获取到accessToken")
        }
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        if cancelled{
            print("用户取消了登录")
        }else{
            print("登录失败")
        }
    }
    
    func tencentDidNotNetWork() {
        print("网络错误，无法登录")
    }
    
    func getUserInfoResponse(_ response: APIResponse!) {
        print("----------------------------------------")
        print("用户资料获取成功：")
        print(response.jsonResponse)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

