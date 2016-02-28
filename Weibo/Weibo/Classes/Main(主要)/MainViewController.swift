//
//  MainViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // --------------------------------------------------------------------
        // 1.添加子控制器
//        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
//        addChildViewController(HomeViewController(), title: "消息", imageName: "tabbar_message_center")
//        addChildViewController(HomeViewController(), title: "发现", imageName: "tabbar_discover")
//        addChildViewController(HomeViewController(), title: "我", imageName: "tabbar_profile")
    
    }
    
//    func addChildViewController(childViewController: UIViewController, title: String, imageName: String) {
//        
//        // --------------------------------------------------------------------
//        // 1.将childViewController包装到导航控制器
//        let childNav = UINavigationController(rootViewController: childViewController)
//        
//        // 2.设置标题和图片
//        childViewController.title = title                   // 设置导航栏和tabBarButton的标题
//        childViewController.tabBarItem.image = UIImage(named: imageName)
//        childViewController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
//        
//        // 3.添加子控制器
//        addChildViewController(childNav)
//    }
    
    
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    
    // MARK: ======================================================================
    // MARK: - Private method (业务和逻辑功能相关)
    
    
    // MARK: ======================================================================
    // MARK: - Delegate (代理实现)
    
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    
    
    // MARK: ======================================================================
    // MARK: - Interface (接口)
    
    
    
    
}