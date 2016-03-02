//
//  User.swift
//  Weibo
//
//  Created by liwx on 16/3/2.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class User: NSObject {

    
    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    // MARK: - 存储属性
    /// 头像
    var profile_image_url : String?
    /// 昵称
    var screen_name : String?
    /// 用户认证: 个人认证,企业认证...
    var verified_type : Int = -1
    /// 会员等级
    var mbrank : Int = -1
    
    // MARK: - 自定义构造函数
    init(dict: [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}
