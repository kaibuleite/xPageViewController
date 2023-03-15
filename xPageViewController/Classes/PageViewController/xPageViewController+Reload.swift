//
//  xPageViewController+Reload.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/14.
//

import Foundation

extension xPageViewController {
    
    // MARK: - 数据加载
    /// 加载网络图片
    /// - Parameters:
    ///   - webImageArray: 图片链接
    public func reload(webImageArray : [String],
                       isRepeats : Bool = false)
    {
        var vcArray = [UIViewController]()
        for url in webImageArray {
            let vc = xPageItemImage.xDefaultViewController(webImage: url)
            vcArray.append(vc)
        }
        self.reload(itemViewControllerArray: vcArray,
                    isRepeats: isRepeats)
    }
    /// 加载本地图片
    /// - Parameters:
    ///   - locImageArray: 本地图片
    public func reload(locImageArray : [UIImage],
                       isRepeats : Bool = false)
    {
        var vcArray = [UIViewController]()
        for img in locImageArray {
            let vc = xPageItemImage.xDefaultViewController(locImage: img)
            vcArray.append(vc)
        }
        self.reload(itemViewControllerArray: vcArray,
                    isRepeats : isRepeats)
    }
    /// 加载自定义组件数据
    /// - Parameters:
    ///   - itemViewControllerArray: 视图控制器列表
    ///   - isRepeats: 是否重复显示
    public func reload(itemViewControllerArray : [UIViewController],
                       isRepeats : Bool = false)
    {
        var list = itemViewControllerArray
        guard list.count > 0 else {
            print("⚠️ 数据不能为0")
            return
        }
        guard let first = list.first else {
            print("⚠️ 视图控制器初始化失败")
            return
        }
        // 是否重复
        if list.count == 1, isRepeats {
            // 视图控制器归档
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: first, requiringSecureCoding: false) {
                // 还原拷贝
                let copy1 = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIViewController.self, from: data)
                let copy2 = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIViewController.self, from: data)
                if let vc = copy1 { list.append(vc) }
                if let vc = copy2 { list.append(vc) }
            }
        }
        // 绑定数据
        self.currentPage = 0
        self.pendingPage = 0
        self.totalPage = list.count
        self.itemArray = list
        self.contentScrollView?.isScrollEnabled = (list.count > 1)
        // 设置子控制器样式
        for (i, vc) in itemViewControllerArray.enumerated()  {
            vc.view.tag = i
            // 没有单击事件回调就不用添加手势了
            guard self.clickHandler != nil else { continue }
            vc.view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
            vc.view.addGestureRecognizer(tap)
        }
        self.setViewControllers([first], direction: .forward, animated: false) {
            (finish) in
        }
    }
    /// 手势事件
    @objc func tapItem(_ gesture : UITapGestureRecognizer)
    {
        guard let page = gesture.view?.tag else { return }
        self.clickHandler?(page)
    }
}
