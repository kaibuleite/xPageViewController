//
//  xWebImageView.swift
//  xWebImage
//
//  Created by Mac on 2021/6/11.
//

import UIKit
import xKit

open class xWebImageView: xImageView {
    
    // MARK: - Public Property
    /// 图片链接
    public var webImageURL = ""
    
    // MARK: - Open Override Func
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public Func
    /// 加载网络图片
    public func xSetWebImage(url : String,
                             placeholderImage : UIImage? = xWebImageManager.shared.placeholderImage,
                             completed : (() -> Void)? = nil)
    {
        var str = url
        if url.hasPrefix("http") == false {
            str = xWebImageManager.shared.webImageURLPrefix + url
        }
        // 先解码再编码，防止URL已经编码导致2次编码
        str = str.xToUrlDecodedString() ?? str
        str = str.xToUrlEncodedString() ?? str
        self.webImageURL = str
        self.sd_setImage(with: str.xToURL(), placeholderImage: placeholderImage, options: .retryFailed) {
            (img, err, _, _) in
            completed?()
        }
    }
    
}
