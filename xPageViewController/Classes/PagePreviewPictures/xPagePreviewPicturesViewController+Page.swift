//
//  xPagePreviewPicturesViewController+Page.swift
//  GlobalKit
//
//  Created by Mac on 2023/3/30.
//

import Foundation
import xKit

extension xPagePreviewPicturesViewController {
    
    // MARK: - 添加回调
    /// 添加回调
    public func addLoadCompleted(handler : @escaping xPagePreviewPicturesViewController.xHandlerLoadCompleted)
    {
        self.loadHandler = handler
    }
    public func addChangePage(_ handler : @escaping xPageViewController.xHandlerChangePage)
    {
        self.changeHandler = handler
    }
    public func addClickPage(_ handler : @escaping xPageViewController.xHandlerClickPage)
    {
        self.clickHandler = handler
    }
    
    // MARK: - 初始化Page
    /// 初始化Page
    func initPage()
    {
        self.childPage.isOpenAutoChangeTimer = false
        self.childPage.addChangePage {
            [weak self] (page) in
            guard let self = self else { return }
            self.topNaviBar?.title = "\(page + 1)/\(self.childPage.totalPage)"
            self.changeHandler?(page)
        }
        self.childPage.addClickPage {
            [weak self] (page) in
            guard let self = self else { return }
            self.clickHandler?(page)
            self.dismiss()
        }
    }
    
}
