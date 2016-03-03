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
    // MARK: - Property (懒加载,属性监听)
    
    /// 微博数据
    lazy var statusViewModels : [StatusViewModel] = [StatusViewModel]()
    
    /// 懒加载动画执行代理属性
    lazy var popoverAnimator : WXPopoverAnimator = {
        
        // 1.设置执行动画时,要执行的操作
        let animator = WXPopoverAnimator(startAnimate: { [unowned self](isPresented) -> () in
            self.titleBtn.selected = isPresented
        })
        // 2.设置要弹出的控制器的frame
        animator.presentedFrame = CGRect(x: 100, y: 60, width: 180, height: 250)
        
        return animator
    }()
    
    /// 懒加载标题按钮
    lazy var titleBtn : TitleButton = {
        let titleBtn = TitleButton(type: .Custom)
        titleBtn.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        
        return titleBtn
    }()
    
    
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
        
        // 3.请求微博数据
        loadStatusData()
    }
    
    /// 设置主页导航栏按钮
    private func setupHomeNavitationItems() {
        
        // 1.创建左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: "leftItemClick")
        
        // 2.创建右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: "rightItemClick")
        
        // 3.设置标题按钮
       navigationItem.titleView = titleBtn
    }
    
    // MARK: ======================================================================
    // MARK: - Private method (业务和逻辑功能相关)
    
    /// 请求网络数据
    private func loadStatusData() {
        
        // 请求网络属数据
        NetworkTools.shareInstance.loadStatusData { (result, error) -> () in
            
            // 1.错误校验
            if error != nil {
                WXLog(error)
                return
            }
            
            // 2.获取结果
            for statusDict in result! {
                self.statusViewModels.append(StatusViewModel(status: Status(dict: statusDict)))
            }
            
            // 3.设置tableView的估算高度
            self.tableView.estimatedRowHeight = 200
            self.tableView.rowHeight = UITableViewAutomaticDimension
            
            // 4.刷新表格
            self.tableView.reloadData()
        }
        
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
        popoverVc.transitioningDelegate = popoverAnimator
        
        // 4.使用Modal方式弹出PopoverViewController控制器
        presentViewController(popoverVc, animated: true, completion: nil)
    }
    
}

// MARK: - TableView的数据源
extension HomeViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusViewModels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.storyboard中设置cell
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as? HomeCell
        
        // 2.设置cell数据
        cell?.statusViewModel = statusViewModels[indexPath.row]
        
        
        return cell!
    }
}
