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
    
    // MARK: - Handler
    public typealias xHandlerLoadCompleted = () -> Void
    
    // MARK: - Override Property
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Override Property
    public override var typeEmoji: String { return "👁" }
    
    // MARK: - Public Property
    public var minimumZoomScale = CGFloat(1)
    public var maximumZoomScale = CGFloat(3)
    
    var loadHandler : xPagePreviewPicturesViewController.xHandlerLoadCompleted?
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
        self.view.backgroundColor = .black
        self.view.isHidden = true
        self.initPage()
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 自动释放
        self.dismiss()
    }
    
    public override func addChildren() {
        self.xAddChild(viewController: self.childPage, in: self.childContainer!)
    } 
    
}
