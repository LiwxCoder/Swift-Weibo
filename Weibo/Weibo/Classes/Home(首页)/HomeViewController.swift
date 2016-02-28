//
//  HomeViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.如果不是登录状态,则显示访客界面,添加转盘动画
        guard isLogin else {
            setupVisitorNavigationItems()
            visitorView?.addRotationAnimation()
            return
        }
        
        // 2.如果已经登录,设置首页导航栏左右侧按钮
        setupHomeNavitationItems()
        
    }
    
    /// 设置主页导航栏按钮
    private func setupHomeNavitationItems() {
        
        // 1.创建左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: "leftItemClick")
        
        // 2.创建右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: "rightItemClick")
        
        // 3.设置标题按钮
        let titleButton = TitleButton()
        titleButton.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleButton
    }
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    
    // MARK: ---- 监听导航栏按钮点击
    /// 监听导航栏左侧按钮的点击
    @objc private func leftItemClick() {
        WXLog("leftItemClick")
    }
    /// 监听导航栏右侧按钮的点击
    @objc private func rightItemClick() {
        WXLog("rightItemClick")
    }
    
    @objc private func titleButtonClick(titleButton: TitleButton) {
        titleButton.selected = !titleButton.selected
    }
    
    
    
    

}
