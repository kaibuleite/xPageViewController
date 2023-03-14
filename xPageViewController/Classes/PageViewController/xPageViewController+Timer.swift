//
//  xPageViewController+Timer.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/14.
//

import Foundation
import xExtension

extension xPageViewController {
    
    // MARK: - 定时器
    /// 开启定时器
    public func openTimer()
    {
        self.closeTimer()   // 防止定时器多开
        let timer = Timer.xNew(timeInterval: self.changeInterval, repeats: true) {
            [weak self] (sender) in
            guard let self = self else { return }
            guard self.itemArray.count > 0 else { return }
            let newPage = self.currentPage + 1
            self.changePage(to: newPage)
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }
    
    /// 关闭定时器
    public func closeTimer()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
    
}
