//
//  String-Extension.swift
//  Weibo
//
//  Created by liwx on 16/3/2.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit


extension String {
    // 结构的类方法以static开头
    // 类的类方法以class开头
    static func createTimeString(dateString : String) -> String {
        // 1.创建dateFmt对时间进行格式化
        let fmt = NSDateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = NSLocale(localeIdentifier: "en")
        
        // 2.将字符串转成时间
        guard let createDate = fmt.dateFromString(dateString) else {
            return ""
        }
        
        // 3.获取当前时间
        let nowDate = NSDate()
        
        // 4.比较两个时间差
        let interval = Int(nowDate.timeIntervalSinceDate(createDate))
        
        // 5.根据时间差,计算要显示的字符串
        // 5.1.1分钟内:刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.1小时内:15分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3.1天内:3小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        let calendar = NSCalendar.currentCalendar()
        // 5.4.昨天: 昨天 03:24
        if calendar.isDateInYesterday(createDate) {
            
            fmt.dateFormat = "HH:mm"
            return "昨天 \(fmt.stringFromDate(createDate))"
        }
        
        // 5.5.一年内: 02-23 03:24
        let comps =  calendar.components(.Year, fromDate: createDate, toDate: nowDate, options: [])
        if comps.year < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            return fmt.stringFromDate(createDate)
        }
        
        // 5.6.一年后: 2015-2-23 03:23
        if comps.year >= 1 {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            return fmt.stringFromDate(createDate)
        }
        
        return ""
    }
}

