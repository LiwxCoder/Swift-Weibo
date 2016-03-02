//
//  WelcomeViewController.swift
//  Weibo
//
//  Created by liwx on 16/3/2.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置用户信息
        nameLabel.text = UserAccountViewModel.sharedInstance.account?.screen_name
        iconView.sd_setImageWithURL(UserAccountViewModel.sharedInstance.avatarUrl, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 2.设置用户圆形头像,也可以在storyboard中使用KVC设置
        iconView.layer.cornerRadius = iconView.frame.size.width * 0.5
        iconView.layer.masksToBounds = true
        
        // 3.执行弹跳动画
        // Damping : 阻力系数
        // Velocity : 初始化速度
        // 在Swift中,如果一个枚举类型不设置值: []/UIViewAnimationOptions(rawValue: 0)
        iconViewBottomCons.constant = 500
        UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
                // 强制刷新
                self.view.layoutIfNeeded()
            }) { (isFinished) -> Void in
                
                // 动画执行完成,显示主界面
                UIApplication.sharedApplication().keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
    }

}
