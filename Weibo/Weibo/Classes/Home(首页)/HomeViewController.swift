//
//  HomeViewController.swift
//  Weibo
//
//  Created by liwx on 16/2/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: ======================================================================
    // MARK: - Life cycle (生命周期，类似addSubview和Notification的监听和销毁都放在这里)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.如果不是登录状态,则显示访客界面,添加转盘动画
        guard isLogin else {
            setupVisitorNavigationItems()
            visitorView?.addRotationAnimation()
            return
        }
        
        // 2.如果已经登录,设置首页导航栏左右侧按钮
        setupHomeNavitationItems()
        
    }
    
    /// 设置主页导航栏按钮
    private func setupHomeNavitationItems() {
        
        // 1.创建左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: "leftItemClick")
        
        // 2.创建右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: "rightItemClick")
        
        // 3.设置标题按钮
        let titleButton = TitleButton()
        titleButton.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleButton
    }
    
    // MARK: ======================================================================
    // MARK: - Event response (事件处理)
    
    // MARK: ---- 监听导航栏按钮点击
    /// 监听导航栏左侧按钮的点击
    @objc private func leftItemClick() {
        WXLog("leftItemClick")
    }
    /// 监听导航栏右侧按钮的点击
    @objc private func rightItemClick() {
        WXLog("rightItemClick")
    }
    
    @objc private func titleButtonClick(titleButton: TitleButton) {
        titleButton.selected = !titleButton.selected
        
        // 1.创建PopoverVc
        let popoverVc = PopoverViewController()
        
        // 2.设置PopoverVc的Modal弹出样式为自定义样式
        // 默认情况下modal出一个控制器后,会将之前显示的控制器移除掉
        // 如果不希望移除控制器,可以将modalPresentationStyle设置为自定义样式
        popoverVc.modalPresentationStyle = .Custom
        
        // 3.自定义Modal,需要设置转场的代理
        popoverVc.transitioningDelegate = self
        
        // 4.使用Modal方式弹出PopoverViewController控制器
        presentViewController(popoverVc, animated: true, completion: nil)
    }
    
}



extension HomeViewController : UIViewControllerTransitioningDelegate {
    
    /// 返回Modal出来的容器控制器,决定弹出控制器的尺寸和位置
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        // 返回: UIPresentationController : 决定弹出的View长什么样子
        // presented: 发起控制器
        // presenting: modal出来的控制器
        
        let presentationController = WXPresentationController(presentedViewController: presented, presentingViewController: presenting)
        presentationController.presentedFrame = CGRect(x: 100, y: 60, width: 180, height: 250)
        
        return presentationController
    }
    
    /// 自定义弹出动画,并且告诉系统弹出动画交给谁来处理,必须自定义弹出动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 1.使用闭包传递数据,闭包内执行弹出动画是用执行的操作
        
        // 2.返回要管理弹出动画的对象
        return self
        
    }
    
    // 自定义消失动画,并且告诉系统消失动画交给谁来处理,必须自定义消失动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 1.使用闭包传递数据,闭包内执行弹出动画是用执行的操作
        
        // 2.返回要管理弹出动画的对象
        return self
    }

}

extension HomeViewController : UIViewControllerAnimatedTransitioning {

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











