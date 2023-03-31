//
//  xPagePreviewPicturesViewController+Page.swift
//  GlobalKit
//
//  Created by Mac on 2023/3/30.
//

import Foundation
import xKit

extension xPagePreviewPicturesViewController {
    
    // MARK: - 初始化Page
    /// 初始化Page
    func initPage()
    {
        self.childPage.isOpenAutoChangeTimer = false
        self.childPage.addChangePage {
            [weak self] (page) in
            guard let self = self else { return }
            self.topNaviBar?.title = "\(page + 1)/\(self.childPage.totalPage)"
        }
        self.childPage.addClickPage {
            [weak self] (page) in
            guard let self = self else { return }
            self.dismiss()
        }
    }
    
}
