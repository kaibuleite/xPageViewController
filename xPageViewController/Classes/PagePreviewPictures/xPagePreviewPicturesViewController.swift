//
//  xPagePreviewPicturesViewController.swift
//  GlobalKit
//
//  Created by Mac on 2023/3/29.
//

import UIKit
import xKit
import xExtension

public class xPagePreviewPicturesViewController: xViewController {
    
    // MARK: - Override Property
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Public Property
    public var maximumZoomScale = CGFloat(3)
    public var minimumZoomScale = CGFloat(1)
    
    // MARK: - Child
    let childPage = xPageViewController.xDefaultViewController()
    
    // MARK: - Override Func
    public override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(storyboard: nil)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .black
        self.view.alpha = 0
        self.initPage()
    }
    
    public override func addChildren() {
        self.xAddChild(viewController: self.childPage, in: self.childContainer!)
    }
    
    // MARK: - 显示隐藏
    /// 显示
    public func display()
    {
        self.view.superview?.bringSubviewToFront(self.view)
        self.view.alpha = 1
    }
    
    /// 隐藏
    public func dismiss()
    {
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
        }
    }
    
}
