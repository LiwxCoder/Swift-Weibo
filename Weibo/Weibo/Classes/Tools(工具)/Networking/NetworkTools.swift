//
//  NetworkTools.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit
import AFNetworking

// MARK: ---- 定义网络请求方法枚举类型
enum WXRequestMethod : String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {

    // let修饰的常量就是线程安全的
    /// 1.设置NetworkTools为单例
    static let shareInstance : NetworkTools = {
        
        // 1.创建单例对象
        let tools = NetworkTools(baseURL: NSURL(string: "https://api.weibo.com/"))
        // 2.添加请求体类型
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
}

// MARK: ======================================================================
// MARK: - Interface (接口)
// MARK: ---- 封装网络请求
extension NetworkTools {
    
    /// 1.封装网络请求
    func request(method: WXRequestMethod, urlString: String, parameters: [String : AnyObject]?, finished: (result: AnyObject?, error: NSError?)->()) {
    
        // 1.定义成功时调用的回调闭包
        let success = { (task: NSURLSessionDataTask, result: AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 2.定义失败的回调闭包
        let failure = { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            finished(result: nil, error: error)
        }
        
        if method == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else{
            POST(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}

// MARK: ---- 封装请求获取accessToken
extension NetworkTools {
    
    /// 1.封装请求accessToken
    func loadAccessToken(code: String, finished: (result: [String : AnyObject]? , error: NSError?) -> ()) {
    
        // 1.获取请求的URLString
        let urlString = "oauth2/access_token"
        
        // 2.拼接参数
        let parameters = ["client_id" : appKey, "client_secret" : appSecret, "grant_type" : "authorization_code", "code" : code, "redirect_uri" : redirectUri]
        
        // 3.发送请求
        request(.POST, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
        }
    }
}

/// 请求用户的信息
extension NetworkTools {

    // 请求用户信息
    func loadUserInfo(access_token: String, uid: String, finished: (result: [String : AnyObject]?, error: NSError?) -> ()) {
    
        // 1.获取URLString
        let urlString = "2/users/show.json"
        
        // 2.拼接参数
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        // 3.发送请求
        request(.GET, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
        }
        
        
    }
}

/// 请求微博数据
extension NetworkTools {

   // 请求微博数据
    func loadStatusData(isFinished: (result: [[String : AnyObject]]?, error: NSError?) -> ()) {
    
        // 1.获取urlString
        let urlString = "2/statuses/home_timeline.json"
        
        // 2.拼接参数
        guard let access_token = UserAccountViewModel.sharedInstance.account?.access_token else {
            return
        }
        let parameters = ["access_token" : access_token]
        
        // 3.发送请求
        request(.GET, urlString: urlString, parameters: parameters) { (result, error) -> () in
            
            // 3.1 错误校验
            if error != nil {
                isFinished(result: nil, error: error)
                return
            }
            
            // 3.2 将AnyObject转成字典
            guard let resultDict = result else {
                isFinished(result: nil, error: error)
                return
            }
            
            // 3.3 从resultDict字典中获取字典数组
            guard let resultArray = resultDict["statuses"] as? [[String : AnyObject]] else {
                isFinished(result: nil, error: NSError(domain: "com.liwx.com", code: 1002, userInfo: ["errorInfo" : "从字典中通过statuses取出字典数组失败"]))
                return
            }
            
            // 3.4 回调结果
            isFinished(result: resultArray, error: nil)
        }
    }
}


