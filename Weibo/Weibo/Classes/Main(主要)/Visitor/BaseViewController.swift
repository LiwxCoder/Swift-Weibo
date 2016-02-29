//
//  BaseViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/28.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    /// 登录状态
    var isLogin = false
    var visitorView : VisitorView?
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    /// 加载view
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 设置导航条注册,登录按钮
    func setupVisitorNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Done, target: self, action: "registerClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Done, target: self, action: "loginClick")
    }
    
    /// 初始化访客视图
    func setupVisitorView() {
        // 1.从xib创建访客视图,设置控制的view为visitorView
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        // 2.添加登录,注册按钮的监听
        visitorView?.registerBtn.addTarget(self, action: "registerClick", forControlEvents: .TouchUpInside)
        visitorView?.loginBtn.addTarget(self, action: "loginClick", forControlEvents: .TouchUpInside)
    }
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    // MARK: ---- 事件监听函数
    @objc private func registerClick() {
        print("registerClick")
    }
    
    @objc private func loginClick() {
       
        // 1.弹出授权控制器
        let oauthVc = OAuthViewController()
        
        // 2.包装导航控制器
        let navVc: UINavigationController = UINavigationController(rootViewController: oauthVc)
        
        // 3.弹出控制器
        presentViewController(navVc, animated: true, completion: nil)
    }


}
