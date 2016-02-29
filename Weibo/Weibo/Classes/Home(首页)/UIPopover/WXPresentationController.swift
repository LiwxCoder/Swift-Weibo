//
//  WXPresentationController.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class WXPresentationController: UIPresentationController {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    var presentedFrame : CGRect?
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    /// 设置要使用Modal方式弹出的控制器的view的尺寸,并添加遮盖(在遮盖上添加手势),目的是为了点击其他区域是dismiss控制器
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 1.设置弹出的View尺寸
        // ??: ??前面的语句有可选类型,如果其中一个可选类型为nil,则取??后面的值
        presentedView()?.frame = presentedFrame ?? CGRectZero
        
        // 2.添加遮盖
        setupCoverView()
    }
    
    
    private func setupCoverView() {
        
        // 1.创建遮盖
        let coverView = UIView(frame: containerView!.bounds)
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        // 2.给遮盖添加手势
        let tagGes = UITapGestureRecognizer(target: self, action: "coverClick")
        coverView.addGestureRecognizer(tagGes)
        
        // 3.将遮盖添加到容易视图中
        containerView?.insertSubview(coverView, belowSubview: presentedView()!)
    }
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    @objc private func coverClick() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
