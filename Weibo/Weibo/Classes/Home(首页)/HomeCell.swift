//
//  HomeCell.swift
//  Weibo
//
//  Created by liwx on 16/3/3.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UITableViewCell {
    
    
    // MARK:- 拖线的属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    // MARK: - 微博视图模型
    var statusViewModel : StatusViewModel? {
        
        didSet {
            
            // 1.设置头像
            iconView.sd_setImageWithURL(statusViewModel?.iconURL, placeholderImage: UIImage(named: "avatar_default"))
            
            // 2.设置认证图片
            verifiedView.image = statusViewModel?.verifiedImage
            
            // 3.设置昵称
            screenNameLabel.text = statusViewModel?.status?.user?.screen_name
            
            // 4.设置vip图标
            vipView.image = statusViewModel?.vipImage
            
            // 5.时间的Label
            createTimeLabel.text = statusViewModel?.createdAtText
            
            // 6.设置来源
            sourceLabel.text = statusViewModel?.sourceText
            
            // 7.设置微博内容
            contentLabel.text = statusViewModel?.status?.text
        
        }
    
    }

}
