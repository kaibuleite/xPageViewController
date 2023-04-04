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
    var minimumZoomScale = CGFloat(1)
    var maximumZoomScale = CGFloat(3)
    
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
        self.contentScroll.maximumZoomScale = self.maximumZoomScale
        self.contentScroll.minimumZoomScale = self.minimumZoomScale
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.contentScroll.setZoomScale(1, animated: false)
    }
    
    // MARK: - 加载图片
    /// 图片加载完成
    override func loadImageCompleted()
    {
        // 添加控件
        let icon = self.imageIcon
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
        let view = self.contentScroll.subviews.first
//        print("缩放对象 \(view)")
        return view
    }
     
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView,
                                           with view: UIView?)
    {
//        print("开始缩放")
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
//        print("缩放中")
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                                        with view: UIView?,
                                        atScale scale: CGFloat)
    {
//        print("缩放结束")
    }
    
}
