//
//  xPagePicturesViewController.swift
//  xPageViewController
//
//  Created by Mac on 2023/4/3.
//

import UIKit
import xKit
import xExtension

public class xPagePicturesViewController: xViewController {
    
    // MARK: - Handler
    public typealias xHandlerLoadCompleted = (CGFloat, CGFloat) -> Void
    
    // MARK: - Override Property
    public override var typeEmoji: String { return "🎨" }
    
    // MARK: - Public Property
    /// 是否自动调整图片缩放类型
    public var isAutoAdjustScale = true
    /// 是否自动调整图片位置
    public var isAutoAdjustFrame = true
    
    var maxPictureHeight = CGFloat.leastNormalMagnitude
    var minPictureHeight = CGFloat.greatestFiniteMagnitude
    
    var loadHandler : xPagePicturesViewController.xHandlerLoadCompleted?
    var changeHandler : xPageViewController.xHandlerChangePage?
    var clickHandler : xPageViewController.xHandlerClickPage?
    
    // MARK: - Child
    public let childPage = xPageViewController.xDefaultViewController()
    
    // MARK: - 内存释放
    deinit {
        self.loadHandler = nil
        self.changeHandler = nil
        self.clickHandler = nil
    }
    
    // MARK: - Override Func
    public override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(storyboard: nil)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .clear
        self.initPage()
    }
    
    public override func addChildren() {
        self.xAddChild(viewController: self.childPage, in: self.childContainer!)
    }
    
}
