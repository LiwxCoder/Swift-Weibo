//
//  UserAccount.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    
    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    /// access_token : 令牌, 普通钥匙(账号和密码)/泊车钥匙(令牌)
    var access_token : String?
    /// 生命周期
    var expires_in : NSTimeInterval = 0.0 {
        didSet {
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户ID
    var uid : String?
    /// 过期日期
    var expiresDate : NSDate?
    /// 用户头像的地址
    var avatar_large : String?
    /// 用户昵称
    var screen_name : String?
    
    // MARK: - 自定义构造函数
    init(dict: [String : AnyObject]) {
        super.init()

        setValuesForKeysWithDictionary(dict)
    }
    
    /// 重写该方法,避免模型中没有属性,导致程序奔溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    /// 重写description计算属性,打印时打印对应的内容
    override var description : String {
        let dict = dictionaryWithValuesForKeys(["access_token", "expires_in", "uid", "expiresDate", "avatar_large", "screen_name"])
        
        return dict.description
    }
    
    // MARK: ---- 归档和解档
    
    /// 归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expiresDate, forKey: "expiresDate")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
    /// 解档
    // required : 指定构造函数,指定构造函数没有继承性.子类不能通过该方法创建出来子类对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expiresDate = aDecoder.decodeObjectForKey("expiresDate") as? NSDate
        uid = aDecoder.decodeObjectForKey("uid") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    /// 保存用户信息
//    func saveAccount() {
//        
//        // 1.获取沙盒路径
//        var accountPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
//        
//        // 2.拼接路径
//        accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
//        
//        WXLog(accountPath)
//        
//        // 3.归档
//        NSKeyedArchiver.archiveRootObject(self, toFile: accountPath)
//    }
    
}
