//
//  xPageItemPicture.swift
//  Alamofire
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension
import xWebImage

public class xPageItemPicture: xPageItem {
    
    // MARK: - Handler
    typealias xHandlerLoadPictureCompleted = (CGSize) -> Void
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var refreshingView: UIActivityIndicatorView!

    // MARK: - Public Property
    override var typeEmoji: String { return "🌅" }
    public var isAutoScale = false
    var webImage = ""
    var locImage = UIColor.xNewRandom(alpha: 0.5).xToImage()
    var imageIcon = UIImageView()
    var imageScaleWidth = CGFloat.zero
    var imageScaleHeight = CGFloat.zero
    var loadHandler : xPageItemPicture.xHandlerLoadPictureCompleted?
    
    // MARK: - 内存释放
    deinit {
        self.loadHandler = nil
    }
    
    // MARK: - Override Func
    public class func xDefaultViewController(locImage : UIImage) -> Self {
        let vc = Self.xDefaultViewController()
        vc.locImage = locImage
        return vc
    }
    public class func xDefaultViewController(webImage : String) -> Self {
        let vc = Self.xDefaultViewController()
        vc.webImage = webImage
        return vc
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .clear
        self.refreshingView.isHidden = true
        self.refreshingView.stopAnimating()
    }
    
    // MARK: - 添加图片
    public override func addKit()
    {
        if self.webImage.xContains(subStr: "http") {
            self.refreshingView.isHidden = false
            self.refreshingView.startAnimating()
            xWebImageManager.downloadImage(url: self.webImage) {
                (receivedSize, expectedSize, targetURL) in
                
            } completed: {
                [weak self] (image, data, error, finished) in
                guard let self = self else { return }
                self.refreshingView.isHidden = true
                self.refreshingView.stopAnimating()
                self.locImage = image
                self.loadImage(image)
            }
        } else {
            self.loadImage(self.locImage)
        }
    }
    // MARK: - 加载图片
    /// 加载图片
    func loadImage(_ image : UIImage?)
    {
        defer {
            self.loadImageCompleted()
        }
        guard let img = image else { return }
        // 按比例修改图片容器大小
        let imgW = img.size.width
        let imgH = img.size.height
        var frame = self.view.bounds
        // 宽度等于自身，高度自适应
        self.imageScaleWidth = frame.width
        self.imageScaleHeight = frame.size.width * imgH / imgW
        frame.size.height = self.imageScaleHeight
        let icon = self.imageIcon
        icon.frame = frame
        icon.image = img
        icon.contentMode = .scaleAspectFit
        guard self.isAutoScale else { return }
        if self.imageScaleWidth > self.imageScaleHeight {
            icon.contentMode = .scaleAspectFill
        } else {
            icon.contentMode = .scaleAspectFit
        }
    }
    /// 图片加载完成
    func loadImageCompleted()
    {
        // 添加控件
        let icon = self.imageIcon
        self.view.addSubview(icon)
        self.view.bringSubviewToFront(self.refreshingView)
        // 调整位置 
        // 回调信息
        let size = CGSize(width: self.imageScaleWidth,
                          height: self.imageScaleHeight)
        self.loadHandler?(size)
    }
    
    // MARK: - 添加回调
    /// 添加回调
    func addLoadPictureCompleted(handler : @escaping xPageItemPicture.xHandlerLoadPictureCompleted)
    {
        self.loadHandler = handler
    }
    
}
