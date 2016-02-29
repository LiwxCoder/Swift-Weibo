//
//  AppDelegate.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        
//        // 1.创建window
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window?.backgroundColor = UIColor.redColor()
//        // 2.设置根控制器
//        window?.rootViewController = MainViewController()
//        // 3.设置keyWindow并显示
//        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// ----------------------------------------------------------------------------
// 自定义Log
// 1.Swift中可以定义全局函数
// 2.使用泛型  WXLog<T>(message : T 表示传递的是什么类型,message就是什么类型
func WXLog<T>(message: T, file: String = __FILE__, funcName: String = __FUNCTION__, lineNum: Int = __LINE__) {
    
    // 1.获取文件名,包含后缀名
    let name = (file as NSString).lastPathComponent
    
    // 1.1 切割文件名和后缀名
    let fileArray = name.componentsSeparatedByString(".")
    // 1.2 获取文件名
    let fileName = fileArray[0]
    
    // 2.打印内容
    print("[\(fileName) \(funcName)](\(lineNum)): \(message)")
    
}

