//
//  VisitorView.swift
//  Weibo
//
//  Created by liwx on 16/2/28.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    /// xib创建view
    class func visitorView() -> VisitorView {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).first as! VisitorView
    }
    
    // MARK: ======================================================================
    // MARK: - Interface (接口)
    func setupVisitorInfo(iconName: String, hintText: String) {
        iconView.image = UIImage(named: iconName)
        hintLabel.text = hintText
        rotationView.hidden = true
    }
    
    func addRotationAnimation() {
        
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2.设置动画属性. removedOnCompletion = false: 为了让动画消失再显示时能正常继续动画
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 10
        rotationAnim.removedOnCompletion = false
        
        // 3.添加动画到layer
        rotationView.layer.addAnimation(rotationAnim, forKey: nil)
    }

}
