//
//  UserAccountViewModel.swift
//  Weibo
//
//  Created by liwx on 16/3/1.
//  Copyright © 2016年 liwx. All rights reserved.
//

import Foundation

// 给闭包取别名
typealias Success = (isSuccess: Bool) -> ()

class UserAccountViewModel {

    // 设计成单例
    static let sharedInstance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    // MARK: - 存储属性
    /// 模型
    var account : UserAccount?
    
    // MARK: - 计算属性
    /// 授权过期状态
    var isExpired : Bool {
        // 与当前时间进行比较
        return account?.expiresDate?.compare(NSDate()) == NSComparisonResult.OrderedAscending
    }
    
    /// 登录状态
    var isLogin : Bool {
        // 根据如果用户和授权状态判断登录状态
        return account != nil && !isExpired
    }
    
    /// 用户信息存放路径
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return (accountPath as NSString).stringByAppendingPathComponent("account.plist")
    }
    
    // MARK: - 自定义构造函数
    init() {
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }
}

extension UserAccountViewModel {

    /// 封装请求网络数据
    func loadAccessToken(code: String, isSuccess: Success) {
        // 请求AccessToken
        NetworkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            
            // 1.错误校验
            if error != nil {
                WXLog(error)
                isSuccess(isSuccess: false)
                return
            }
            
            // 2.获取授权信息
            guard let resultDict = result else {
                WXLog("没有获取到授权信息")
                isSuccess(isSuccess: false)
                return
            }
            
            // 3.将字典转成模型对象
            let account = UserAccount(dict: resultDict)
            
            // 4.请求用户信息
            self.loadUserInfo(account, isSuccess: isSuccess)
        }
    }
    
    /// 请求用户信息
    func loadUserInfo(account: UserAccount, isSuccess: Success) {
        
        // 1.判断accessToken是否有值
        guard let accessToken = account.access_token else {
            WXLog("没有获取到acessToken")
            isSuccess(isSuccess: false)
            return
        }
        
        // 2.判断uid是否有值
        guard let uid = account.uid else {
            WXLog("没有获取到uid")
            isSuccess(isSuccess: false)
            return
        }
        
        // 3.发送请求
        NetworkTools.shareInstance.loadUserInfo(accessToken, uid: uid) { (result, error) -> () in
            
            // 3.1 错误校验
            if error != nil {
                WXLog(error)
                isSuccess(isSuccess: false)
                return
            }
            
            // 3.2 获取结果 
            guard let userInfoDict = result else {
                WXLog("没有获取到用户信息")
                isSuccess(isSuccess: false)
                return
            }
            
            // 3.3 获取用户信息并且保存头像地址和昵称
            account.avatar_large = userInfoDict["avatar_large"] as? String
            account.screen_name = userInfoDict["screen_name"] as? String
            
            // 3.4保存account的信息
            NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
            
            // 4.加载完成
            isSuccess(isSuccess: true)
        }
        
        
    }
    
    
}
