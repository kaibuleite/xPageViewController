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
    var imageIcon : xWebImageView?
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
    
    public override func addKit() {
        guard self.webImage.xContains(subStr: "http") else {
            self.addImageIcon()
            return
        }
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
            self.addImageIcon()
        }
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageIcon?.layoutIfNeeded()
    }
    
    // MARK: - 图片容器
    /// 添加图片容器
    func addImageIcon()
    {
        // 创建图片控件
        guard let icon = self.createImageIcon() else { return }
        // 添加控件
        self.imageIcon = icon
        self.view.addSubview(icon)
        self.view.bringSubviewToFront(self.refreshingView)
        // 调整位置 
        // 回调信息
        let size = CGSize(width: self.imageScaleWidth,
                          height: self.imageScaleHeight)
        self.loadHandler?(size)
    }
    /// 创建图片容器
    func createImageIcon() -> xWebImageView?
    {
        guard let img = self.locImage else { return nil }
        // 按比例修改图片容器大小
        let imgW = img.size.width
        let imgH = img.size.height
        var frame = self.view.bounds
        // 宽度等于自身，高度自适应
        self.imageScaleWidth = frame.width
        self.imageScaleHeight = frame.size.width * imgH / imgW
        frame.size.height = self.imageScaleHeight
        let icon = xWebImageView.init(frame: frame)
        icon.image = img
        icon.contentMode = .scaleAspectFit
        guard self.isAutoScale else { return icon }
        if self.imageScaleWidth > self.imageScaleHeight {
            icon.contentMode = .scaleAspectFill
        } else {
            icon.contentMode = .scaleAspectFit
        }
        return icon
    }
    
    // MARK: - 添加回调
    /// 添加回调
    func addLoadPictureCompleted(handler : @escaping xPageItemPicture.xHandlerLoadPictureCompleted)
    {
        self.loadHandler = handler
    }
    
}
