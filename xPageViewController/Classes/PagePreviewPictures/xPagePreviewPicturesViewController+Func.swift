//
//  xPagePreviewPicturesViewController+Func.swift
//  xPageViewController
//
//  Created by Mac on 2023/4/11.
//

import Foundation
import UIKit

extension xPagePreviewPicturesViewController {
    
    // MARK: - 显示
    /// 显示
    public static func display(from parent : UIViewController,
                               locImageArray : [UIImage],
                               select idx : Int = 0)
    {
        guard locImageArray.count > 0 else {
            print("⚠️ 请传入要预览的图片")
            return
        }
        let preview = xPagePreviewPicturesViewController.xDefaultViewController()
        parent.xAddChild(viewController: preview, in: parent.view)
        
        preview.display()
        preview.reload(locImageArray: locImageArray, select: idx)
    }
    public static func display(from parent : UIViewController,
                               webImageArray : [String],
                               select idx : Int = 0)
    {
        guard webImageArray.count > 0 else {
            print("⚠️ 请传入要预览的图片")
            return
        }
        let preview = xPagePreviewPicturesViewController.xDefaultViewController()
        parent.xAddChild(viewController: preview, in: parent.view)
        
        preview.display()
        preview.reload(webImageArray: webImageArray, select: idx)
    }
    public func display()
    {
        self.view.superview?.bringSubviewToFront(self.view)
        self.view.alpha = 1
        self.view.isHidden = false
    }
    
    // MARK: - 隐藏
    /// 隐藏
    public func dismiss()
    {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
        } completion: {
            (finished) in
            // 隐藏后直接移除，不然太占内存
            self.view.isHidden = true
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
}
