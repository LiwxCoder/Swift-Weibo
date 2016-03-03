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
    
    /// UICollectionViewCell的宽高
    let itemWH = (UIScreen.mainScreen().bounds.width - 4 * margin) / 3
    
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
    /// UICollectionView底部间距约束
    @IBOutlet weak var picCollectionViewBottomCons: NSLayoutConstraint!
    
    /// 用于展示图片的collectionView
    @IBOutlet weak var picCollectionView: UICollectionView!

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
            
            // 9.刷新UICollectionView
            picCollectionView.reloadData()
        }
    
    }
    
    /// 计算cell的约束
    private func calculate(imageCount: Int) -> (CGFloat, CGFloat) {
    
        // 1.没有配图
        if imageCount == 0 {
            // 1.1.调整collectionView距离底部的约束0
            picCollectionViewBottomCons.constant = 0
            return (0, 10)
        }
        // 2.调整collectionView距离底部的约束10
        picCollectionViewBottomCons.constant = 10
        
        // 2.四张配图
        if imageCount == 4 {
            let height = itemWH * 2 + margin
            let right = UIScreen.mainScreen().bounds.width - 2 * (itemWH + margin)
            
            return (height, right)
        }
        
        // 3.其他配图
        // 公式一: ((imageCount - 1) / 3 + 1) 
        // 公式二: ((imageCount + 2) / 3)
        let row = CGFloat((imageCount - 1) / 3 + 1)
        let height = row * itemWH + (row - 1) * margin
        return (height, 10)
        
    }
    
    // 获取UICollectionView的布局,设置cell的尺寸
    override func awakeFromNib() {
        // 1.获取布局
        let layout = picCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 2.设置item尺寸
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        // 3.设置UICollectionView的数据源为HomeCell
        picCollectionView.dataSource = self
    }
    

}

// MARK: ======================================================================
// MARK: - Delegate (代理实现)
extension HomeCell : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statusViewModel?.picURLs.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("picCell", forIndexPath: indexPath) as! PicCollectionViewCell
        
        // 2.设置cell图片数据
        cell.imageURL = statusViewModel?.picURLs[indexPath.item]
        
        // 3.返回cell
        return cell
    }
}

// MARK: - 自定义UICollectionViewCell
class PicCollectionViewCell: UICollectionViewCell {
    /// 用于展示图片的imageView
    @IBOutlet weak var picImageView: UIImageView!
    
    /// 对用展示数据的NSURL
    var imageURL : NSURL? {
        didSet {
            if imageURL == nil {
                return
            }
            
            picImageView.sd_setImageWithURL(imageURL!, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
}


