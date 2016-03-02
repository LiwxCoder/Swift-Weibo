//
//  Status.swift
//  Weibo
//
//  Created by liwx on 16/3/2.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    // MARK: - 存储属性
    /// 微博创建时间
    var created_at : String?
    /// 字符串型的微博ID
    var idstr : String?
    /// 微博信息内容
    var text : String?
    /// 微博来源
    var source : String?
    /// 用户
    var user : User?
    
        /// 自定义构造函数
    init(dict: [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User(dict: userDict)
        }
    }
    
    /// 重写forUndefinedKey
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    

}
