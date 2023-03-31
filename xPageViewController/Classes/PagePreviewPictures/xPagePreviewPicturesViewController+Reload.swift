//
//  xPagePreviewPicturesViewController+Reload.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/30.
//

import xKit

extension xPagePreviewPicturesViewController {
    
    // MARK: - 重新加载数据
    /// 加载网络图片
    /// - Parameters:
    ///   - webImageArray: 图片链接
    public func reload(webImageArray : [String],
                       select row : Int = 0,
                       isRepeats : Bool = false)
    {
        self.topNaviBar?.title = "\(row + 1)/\(webImageArray.count)"
        var list = [xPageItemPreviewPictures]()
        for url in webImageArray {
            let item = xPageItemPreviewPictures.xDefaultViewController(webImage: url)
            list.append(item)
        }
        self.childPage.reload(itemViewControllerArray: list,
                              isRepeats: isRepeats)
        guard row < list.count else { return }
        self.childPage.changePage(to: row, animated: false)
    }
    /// 加载本地图片
    /// - Parameters:
    ///   - locImageArray: 本地图片
    public func reload(locImageArray : [UIImage],
                       select row : Int = 0,
                       isRepeats : Bool = false)
    {
        self.topNaviBar?.title = "\(row + 1)/\(locImageArray.count)"
        var list = [xPageItemPreviewPictures]()
        for img in locImageArray {
            let item = xPageItemPreviewPictures.xDefaultViewController(locImage: img)
            list.append(item)
        }
        self.childPage.reload(itemViewControllerArray: list,
                              isRepeats: isRepeats)
        guard row < list.count else { return }
        self.childPage.changePage(to: row, animated: false)
    }
    
}
