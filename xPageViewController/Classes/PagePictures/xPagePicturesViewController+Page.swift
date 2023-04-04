//
//  xPagePicturesViewController+Page.swift
//  xPageViewController
//
//  Created by Mac on 2023/4/3.
//

import Foundation
import xKit

extension xPagePicturesViewController {
    
    // MARK: - 添加回调
    /// 添加回调
    public func addLoadCompleted(handler : @escaping xPagePicturesViewController.xHandlerLoadCompleted)
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
        self.childPage.changeInterval = 8
        self.childPage.addChangePage {
            [weak self] (page) in
            guard let self = self else { return }
            self.changeHandler?(page)
        }
        self.childPage.addClickPage {
            [weak self] (page) in
            guard let self = self else { return }
            self.clickHandler?(page)
        }
    }
    
}
