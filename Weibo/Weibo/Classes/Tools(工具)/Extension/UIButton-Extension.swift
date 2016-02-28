//
//  UIButton-Extension.swift
//  Weibo
//
//  Created by liwx on 16/2/28.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

extension UIButton {
    
    // convenience : 便利构造函数
    // Swift中如果在类扩展中扩充构造函数,必须写便利构造函数
    // 便利构造函数:1.必须在构造函数前convenience 2.必须调用self.init()
    convenience init(imageName: String, bgImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    
}
