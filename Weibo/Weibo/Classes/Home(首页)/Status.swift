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
    var source : String? {
        
        didSet {
            
            // 1.nil值的校验,在guard判断多个条件可以通过where连接
            guard let tempSource = source where source != "" else {
                return
            }
            
            // 2.处理来源数据: <a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>
            // 2.1 获取起始
            let startIndex = (tempSource as NSString).rangeOfString(">").location + 1
            // 2.2 计算长度
            let length = (tempSource as NSString).rangeOfString("</").location - startIndex
            // 2.3 截取字符串
            sourceText = (tempSource as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
    }
    /// 微博来源数据处理
    var sourceText : String?
    
    /// 用户
    var user : User?
    
    // MARK: - 计算属性
    var createdAtText : String? {
        guard let tempCreatedAt = created_at else {
            return nil
        }
        
        return String.createTimeString(tempCreatedAt)
    }
    
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
