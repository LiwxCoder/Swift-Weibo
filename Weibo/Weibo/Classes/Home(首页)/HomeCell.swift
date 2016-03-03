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
    
    /// UICollectionView高度约束
    @IBOutlet weak var picCollectionViewHCons: NSLayoutConstraint!
    /// UICollectionView右边间距约束
    @IBOutlet weak var picCollectionViewRCons: NSLayoutConstraint!

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
            
            // 8.动态计算collectionView的高度和距离右边的约束
            let (height, right) = calculate(statusViewModel?.picURLs.count ?? 0)
            picCollectionViewHCons.constant = height
            picCollectionViewRCons.constant = right
        }
    
    }
    
    private func calculate(imageCount: Int) -> (CGFloat, CGFloat) {
    
        // 1.没有配图
        if imageCount == 0 {
            return (0, 10)
        }
        
        // 2.四张配图
        let imageWH = (UIScreen.mainScreen().bounds.width - 4 * margin) / 3
        if imageCount == 4 {
            let height = imageWH * 2 + margin
            let right = UIScreen.mainScreen().bounds.width - 2 * (imageWH + margin)
            
            return (height, right)
        }
        
        // 3.其他配图
        // 公式一: ((imageCount - 1) / 3 + 1) 
        // 公式二: ((imageCount + 2) / 3)
        let row = CGFloat((imageCount - 1) / 3 + 1)
        let height = row * imageWH + (row - 1) * margin
        return (height, 10)
        
    }

}
