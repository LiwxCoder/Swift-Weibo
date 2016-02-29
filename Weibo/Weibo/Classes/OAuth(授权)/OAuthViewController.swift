//
//  OAuthViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    /// 加载授权网页webView
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置导航栏内容
        setupNavigationItems()
        
        // 2.加载登录界面
        loadLoginPage()
    }
    
    /// 设置导航栏的内容
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Done, target: self, action: "close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Done, target: self, action: "autoFill")
        navigationItem.title = "登录界面"
    }
    
    /// 加载登录界面
    private func loadLoginPage() {
        
        // 1.获取页面的地址
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUri)"
        
        // 2.创建NSURL
        guard let url = NSURL(string: urlString) else {
            WXLog("没有获取正确的URL")
            return
        }
        
        // 3.创建NSURLRequest请求对象
        let request = NSURLRequest(URL: url)
        
        // 4.利用webView加载request
        webView.loadRequest(request)
        
    }
    
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    /// 监听关闭按钮点击
    @objc private func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 监听填充按钮点击
    @objc private func autoFill() {
        
        // 1.使用js代码完成帐号密码填充功能
        let jsCode = "document.getElementById('userId').value='1606020376@qq.com';document.getElementById('passwd').value='haomage';"
        
        // 2.执行js代码
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
    }
    

}
