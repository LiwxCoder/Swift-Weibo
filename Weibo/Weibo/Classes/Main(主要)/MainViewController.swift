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
    
    // 已在storyboard中设置好TabBarButton显示的内容,所以就无需再定义该属性
//    lazy var imageNames : [String] = {
//        return ["tabbar_home", "tabbar_message_center", "", "tabbar_discover", "tabbar_profile"]
//    }()
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加加号按钮
        setupComposeBtn()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        adjustItems()
    }
    
    /// 添加发布按钮
    private func setupComposeBtn() {
        // 1.创建发布按钮
        let composeBtn = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
        
        // 2.设置加号按钮的位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        // 3.添加监听
        composeBtn.addTarget(self, action: "composeBtnClick:", forControlEvents: .TouchUpInside)
        
        // 4.添加到tabBar
        tabBar.addSubview(composeBtn)
    }
    
    /// 设置中间加按钮不能点击
    private func adjustItems() {
        
        // 遍历UITabBarItem,设置最中间的item不能点击,目的是为了让中间item的点击事件传递到底部的按钮
        for i in 0..<tabBar.items!.count {
            // 1.取出item
            let item = tabBar.items![i]
            
            // 2.如果是第二个item,则不能交互,这样时间才能传递给下面的加号按钮
            if i == 2 {
                item.enabled = false
                continue
            }
            
            // 3.设置item显示的图片,因为该操作已经在storyboard中设置过,所以此处不再设置
//            item.image = UIImage(named: imageNames[i])
//            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
    }
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    
    // MARK:- 事件监听的函数
    // 事件监听本质是在发送消息
    // 如果一个函数声明private,那么该函数不会在对象的方法列表中
    // 加上@objc,就可以将函数添加到方法列表中
    @objc private func composeBtnClick(composeBtn: UIButton) {
        WXLog("composeBtnClick");
    }
    
    
}