//
//  xPageViewController+Delegate.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/14.
//

import Foundation 
import xExtension

// MARK: - UIPageViewControllerDataSource
extension xPageViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        // print("上一页")
        let page = viewController.view.tag - 1
        let safePage = self.checkPageSafe(page)
        let vc = self.itemArray.xObject(at: safePage)
        return vc
    }
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        // print("下一页")
        let page = viewController.view.tag + 1
        let safePage = self.checkPageSafe(page)
        let vc = self.itemArray.xObject(at: safePage)
        return vc
    }
}

// MARK: - UIPageViewControllerDelegate
extension xPageViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController])
    {
        //print("用户开始换页")
        self.closeTimer()
        // 框架只考虑单页，所以数组其实只有1个元素
        if let vc = pendingViewControllers.last {
            self.pendingPage = vc.view.tag
        }
        //print("pending = \(self.pendingPage)")
    }
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool)
    {
        // print("用户换页完成")
        if self.isOpenAutoChangeTimer {
            self.openTimer()
        }
        guard finished else {
            print("⚠️ 换页事件未结束，中断")
            return
        }
        guard completed else {
            // 一般情况下拖拽进度不够导致回到原来的地方会进这里
            print("⚠️ 换页未完成，继续换页操作")
            return
        }
        // 其他部分放到ScrollDelegate里实现
    }
}

// MARK: - UIScrollViewDelegate
extension xPageViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        // 计算当前页的偏移量
        guard self.itemArray.count > 0 else { return }
        guard let vc = self.itemArray.xObject(at: self.currentPage) else { return }
        let p = vc.view.convert(CGPoint(), to: self.view)
        var direction = xDraggingDirection.next
        var page = self.currentPage
        var progress = CGFloat.zero // 滚动进度
        switch self.navigationOrientation {
        case .horizontal:
            let w = self.view.frame.width
            progress = abs(p.x / w)
            direction = p.x > 0 ? .previous : .next
        default:
            let h = self.view.frame.height
            progress = abs(p.y / h)
            direction = p.y > 0 ? .previous : .next
        }
        // 连续换页
        if progress >= 1 {
            progress -= 1
            page += (direction == .next) ? 1 : -1
        }
        // print(offset)
        // print(self.currentPage, self.pendingPage, progress)
        let safePage = self.checkPageSafe(page)
        self.currentPage = safePage
        guard let handler = self.scrollingHandler else { return }
        let data = xDraggingData.init(fromPage: self.currentPage,
                                      toPage: self.pendingPage,
                                      progress: progress)
        handler(data, direction)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滚动结束
        // print(self.currentPage)
        self.changeHandler?(self.currentPage)
    }
}
