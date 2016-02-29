//
//  OAuthViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    /// 加载授权网页webView
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.设置webView的代理
        webView.delegate = self

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

// MARK: ======================================================================
// MARK: - Delegate (代理实现)

// MARK: ---- webView的代理方法
extension OAuthViewController : UIWebViewDelegate {
    
    /// 开始加载某个页面会调用该方法
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showWithStatus("正在拼命加载界面")
    }
    
    /// 完成加载某个页面会调用该方法
    func webViewDidFinishLoad(webView: UIWebView) {
        // 加载完成,隐藏指示器
        SVProgressHUD.dismiss()
    }
    
    /// 加载某个页面失败时会调用该方法
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        // 加载失败,隐藏指示器
        SVProgressHUD.dismiss()
    }
    
    /// 开始加载某个request请求对象会先调用该方法
    // 返回值: true: 需要继续加载该request  false: 不需要继续加载该request
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 1.获取加载的URL对应的字符串,判断是否有获取到对应的URLString
        guard let urlString = request.URL?.absoluteString else {
            WXLog("没有获取到对应的URLString")
            return true
        }
        
        // 2.判断该urlString是否包含code
        guard urlString.containsString("code=") else {
            WXLog("还没有加载到code,继续加载界面")
            return true
        }
        
        // 3.获取code
        guard let code = urlString.componentsSeparatedByString("code=").last else {
            WXLog("获取code失败")
            return true
        }
        
        // 4.用code换取accessToken
        NetworkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            
            // 1.判断是否请求失败
            if error != nil {
                WXLog(error)
                return
            }
            
            // 2.获取到授权信息
            WXLog(result)
            
        }
        
        return false
    }
}
