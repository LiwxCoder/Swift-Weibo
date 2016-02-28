//
//  UIBarButtonItem-Extension.swift
//  Weibo
//
//  Created by liwx on 16/2/28.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 遍历构造函数
    /// 设置导航条按钮的普通,高亮图片,监听按钮的点击
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}