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

