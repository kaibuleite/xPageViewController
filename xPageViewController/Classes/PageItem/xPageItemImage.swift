//
//  xPageItemImage.swift
//  Alamofire
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension
import xWebImage

public class xPageItemImage: xPageItem {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var refreshingView: UIActivityIndicatorView!

    // MARK: - Public Property
    override var typeEmoji: String { return "🌅" }
    var imgIcon : xWebImageView?
    var webImage = ""
    var locImage : UIImage?
    
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
    
    // MARK: - 图片容器
    /// 添加图片容器
    func addImageIcon()
    {
        guard let icon = self.createImageIcon() else { return }
        self.imgIcon = icon
        icon.center = self.view.center
        self.view.addSubview(icon)
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
        let scaleH = frame.size.width * imgH / imgW
        if scaleH > frame.height {
            frame.size.height = scaleH
        }
        let icon = xWebImageView.init(frame: frame)
        icon.image = img
        icon.contentMode = .scaleAspectFit
        return icon
    }
    
}
