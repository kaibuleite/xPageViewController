//
//  xPageItemPreviewPicture.swift
//  GlobalKit
//
//  Created by Mac on 2023/3/29.
//

import UIKit
import xKit

public class xPageItemPreviewPicture: xPageItemPicture {

    // MARK: - IBOutlet Property
    @IBOutlet public weak var contentScroll: UIScrollView!
    
    // MARK: - Public Property
    override var typeEmoji: String { return "🗾" }
    
    // MARK: - 内存释放
    deinit {
        self.contentScroll.delegate = nil
    }
    
    // MARK: - Override Func
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .black
        self.contentScroll.delegate = self
        guard let parent = self.parent as? xPagePreviewPicturesViewController else { return }
        self.contentScroll.maximumZoomScale = parent.maximumZoomScale
        self.contentScroll.minimumZoomScale = parent.minimumZoomScale
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.contentScroll.setZoomScale(1, animated: false)
    }
    
    // MARK: - 图片容器
    /// 添加图片容器
    override func addImageIcon()
    {
        // 创建图片控件
        guard let icon = self.createImageIcon() else { return }
        // 添加控件
        self.imageIcon = icon
        self.contentScroll.addSubview(icon)
        self.view.bringSubviewToFront(self.refreshingView)
        // 调整位置，保证居中
        var frame = icon.frame
        let imgH = frame.size.height
        let contentH = self.view.bounds.height
        if imgH < contentH {
            frame.size.height = contentH
        }
        icon.frame = frame
        // 调整缩放范围
        self.contentScroll.contentSize = frame.size
        // 回调信息
        let size = CGSize(width: self.imageScaleWidth,
                          height: self.imageScaleHeight)
        self.loadHandler?(size)
    }
    
}

// MARK: - Scroll view delegate
extension xPageItemPreviewPicture: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        let icon = self.contentScroll.subviews.first
        return icon
    }
     
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView,
                                           with view: UIView?)
    {
        // 开始缩放
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
        // 缩放中
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                                        with view: UIView?,
                                        atScale scale: CGFloat)
    {
        // 缩放结束
    }
    
}
