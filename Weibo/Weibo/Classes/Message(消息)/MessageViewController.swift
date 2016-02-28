//
//  MessageViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置访客视图的信息
        visitorView?.setupVisitorInfo("visitordiscover_image_message", hintText: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }

}
