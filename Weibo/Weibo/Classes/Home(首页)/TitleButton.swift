//
//  TitleButton.swift
//  Weibo
//
//  Created by liwx on 16/2/28.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1.设置按钮属性
        setTitle("首页", forState: .Normal)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()
    }
    
    // Swift中如果重写了控件的initWithFrame方法,必须重写init?(coder aDecoder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 如果可选类型取值:如果可选类型是nil,那么最终结果就是nil
        // 如果是设置值或者调用方法:如果可选类型为nil,则后面内容都不在执行
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 5
    }
    
}
