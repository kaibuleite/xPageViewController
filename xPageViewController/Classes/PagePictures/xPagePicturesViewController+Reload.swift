//
//  xPagePicturesViewController+Reload.swift
//  xPageViewController
//
//  Created by Mac on 2023/4/3.
//

import Foundation
import xKit

extension xPagePicturesViewController {
    
    // MARK: - 重新加载数据
    /// 加载网络图片
    /// - Parameters:
    ///   - webImageArray: 图片链接
    public func reload(webImageArray : [String],
                       isRepeats : Bool = false)
    {
        var list = [xPageItemPicture]()
        for url in webImageArray {
            let item = xPageItemPicture.xDefaultViewController(webImage: url)
            list.append(item)
        }
        self.reload(pictures: list, isRepeats: isRepeats)
    }
    /// 加载本地图片
    /// - Parameters:
    ///   - locImageArray: 本地图片
    public func reload(locImageArray : [UIImage],
                       isRepeats : Bool = false)
    {
        var list = [xPageItemPicture]()
        for img in locImageArray {
            let item = xPageItemPicture.xDefaultViewController(locImage: img)
            list.append(item)
        }
        self.reload(pictures: list, isRepeats: isRepeats)
    }
    
    private func reload(pictures list : [xPageItemPicture],
                        isRepeats : Bool = false)
    {
        let group = DispatchGroup()
        for item in list {
            item.isAutoScale = self.isAutoScale
            group.enter()
            item.addLoadPictureCompleted {
                [weak self] (size) in
                group.leave()
                guard let self = self else { return }
                if size.height < self.minPictureHeight { self.minPictureHeight = size.height }
                if size.height > self.maxPictureHeight { self.maxPictureHeight = size.height }
            } 
        }
        self.childPage.reload(itemViewControllerArray: list,
                              isRepeats: isRepeats)
        group.notify(queue: .main) {
            print("图片高度区间【\(self.minPictureHeight),\(self.maxPictureHeight)】")
            self.loadHandler?(self.minPictureHeight, self.maxPictureHeight)
            guard self.isAutoAdjustFrame else { return }
            print("开始自动调整")
            for item in list {
                let icon = item.imageIcon
                var frame = icon.frame
                frame.origin.y = (self.view.bounds.height - frame.height) / 2
                icon.frame = frame
            }
        }
    }
    
}
