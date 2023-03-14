//
//  xPageViewController+Func.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/14.
//

import Foundation

extension xPageViewController {
    
    // MARK: - 页码
    /// 校验页码
    func checkPageSafe(_ page : Int) -> Int
    {
        let count = self.itemArray.count
        guard count > 0 else { return 0 }
        if page >= count {
            return 0
        }
        if page < 0 {
            return count - 1
        }
        return page
    }
    
    // MARK: - 换页
    /// 换页
    public func changePage(to page : Int,
                           animated : Bool = true)
    {
        // print("系统换页")
        guard page != self.currentPage else { return }
        let safePage = self.checkPageSafe(page)
        guard let vc = self.itemArray.xObject(at: safePage) else { return }
        self.currentPage = safePage
        // 获取滚动方向
        var direction = UIPageViewController.NavigationDirection.forward
        if page < self.currentPage {
            direction = .reverse
        }
        // 开始换页
        self.view.isUserInteractionEnabled = false
        self.setViewControllers([vc], direction: direction, animated: animated) {
            [weak self] (finish) in
            guard let self = self else { return }
            // print("系统换页完成")
            self.view.isUserInteractionEnabled = true
            self.changeHandler?(safePage)   // 不要用self.currentPage,不然堆内的数据还是原来的
        }
    }
    
}
