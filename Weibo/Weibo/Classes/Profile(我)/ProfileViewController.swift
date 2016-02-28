//
//  ProfileViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置访客视图的信息
        visitorView?.setupVisitorInfo("visitordiscover_image_profile", hintText: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }

}
