//
//  StatusViewModel.swift
//  Weibo
//
//  Created by liwx on 16/3/2.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class StatusViewModel {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    // MARK: - 微博对象属性
    var status : Status?
    /// 微博来源数据处理
    var sourceText : String?
    
    /// 认证显示的图片
    var verifiedImage : UIImage?
    
    /// 会员显示的图片
    var vipImage : UIImage?
    
    // MARK: - 计算属性
    var createdAtText : String? {
        return String.createTimeString(status?.created_at ?? "")
    }
    
    /// 头像的URL
    var iconURL : NSURL?
    
    // MARK: - 构造函数
    init(status: Status) {
        self.status = status
        
        // 1.微博的非nil校验
        guard let tempStatus = self.status else {
            return
        }
        
        // 2.来源处理
        // 1.nil值的校验,在guard判断多个条件可以通过where连接
        if let tempSource = tempStatus.source where tempStatus.source != "" {
            
            // 2.处理来源数据: <a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>
            // 2.1 获取起始
            let startIndex = (tempSource as NSString).rangeOfString(">").location + 1
            // 2.2 计算长度
            let length = (tempSource as NSString).rangeOfString("</").location - startIndex
            // 2.3 截取字符串
            sourceText = (tempSource as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
        // 3.处理认证图片
        let verified_type = tempStatus.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 4.处理会员图片
        let vipRank = tempStatus.user?.mbrank ?? -1
        if vipRank >= 1 && vipRank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(vipRank)")
        }

        // 5.头像的URL
        if let iconURLString = tempStatus.user?.profile_image_url {
            iconURL = NSURL(string: iconURLString)
        }
    }
    
}
