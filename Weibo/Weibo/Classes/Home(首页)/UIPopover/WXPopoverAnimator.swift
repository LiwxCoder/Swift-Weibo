//
//  WXPopoverAnimator.swift
//  Weibo
//
//  Created by liwx on 16/2/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class WXPopoverAnimator: NSObject {

    // MARK: ======================================================================
    // MARK: - Property (懒加载,属性监听)
    
    /// 由外部设置要显示的控制器view的frame
    var presentedFrame: CGRect?
    
    /// 计算属性,动画执行时执行对应操作,目的是为了让标题按钮的箭头状态切换
    var startAnimate : (isPresented : Bool) -> ()
    
    /// 添加动画代理对象的构造方法
    init(startAnimate : (isPresented : Bool) -> ()) {
        self.startAnimate = startAnimate
    }
    
}

extension WXPopoverAnimator : UIViewControllerTransitioningDelegate {
    
    /// 返回Modal出来的容器控制器,决定弹出控制器的尺寸和位置
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        // 返回: UIPresentationController : 决定弹出的View长什么样子
        // presented: 发起控制器
        // presenting: modal出来的控制器
        
        let presentationController = WXPresentationController(presentedViewController: presented, presentingViewController: presenting)
        presentationController.presentedFrame = presentedFrame
        
        return presentationController
    }
    
    /// 自定义弹出动画,并且告诉系统弹出动画交给谁来处理,必须自定义弹出动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 1.使用闭包传递数据,闭包内执行弹出动画是用执行的操作
        self.startAnimate(isPresented: true)
        
        // 2.返回要管理弹出动画的对象
        return self
        
    }
    
    // 自定义消失动画,并且告诉系统消失动画交给谁来处理,必须自定义消失动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 1.使用闭包传递数据,闭包内执行弹出动画是用执行的操作
        self.startAnimate(isPresented: false)
        
        // 2.返回要管理弹出动画的对象
        return self
    }
    
}

extension WXPopoverAnimator : UIViewControllerAnimatedTransitioning {
    
    // 返回动画要执行的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    // 弹出和消失动画都会执行该方法
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // UITransitionContextFromViewKey : 做消失动画:取出消失的View
        // UITransitionContextToViewKey : 做弹出动画:取出弹出的View
        
        // 1.设置弹出动画
        if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey) {
            
            // 1.将弹出的View添加到容器视图中(containerView)
            transitionContext.containerView()?.addSubview(presentedView)
            
            // 2.设置动画
            // 2.1 改变presentedView的transform属性,设置锚点
            presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            // 2.2 执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                
                // 1.还原弹出控制器的大小 从scale(1.0, 0.0) -> scale(1.0, 1.0)
                presentedView.transform = CGAffineTransformIdentity
                }, completion: { (isFinished) -> Void in
                    
                    // 1.如果自定义动画,在动画结束后必须告诉系统动画已经执行完成
                    transitionContext.completeTransition(true)
            })
            
        } else {
            
            // 1.取出消失的View
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            // 2.执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                
                // 1.执行消失动画 从scale(1.0, 1.0) -> scale(1.0, 0.000001) 0.000001: 由于精度问题不能写0.0
                dismissView.transform = CGAffineTransformMakeScale(1.0, 0.000001)
                }, completion: { (isFinished) -> Void in
                    
                    // 告诉系统,动画已经执行完成
                    transitionContext.completeTransition(true)
                    // 移除view
                    dismissView.removeFromSuperview()
            })
        }
    }
    
}
