//
//  xPageItemImage.swift
//  Alamofire
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension
import xWebImage

open class xPageItemImage: UIViewController {
    
    // MARK: - Handler
    /// 切换页数
    public typealias xHandlerSetImageCompleted = (UIImage?) -> Void
    
    // MARK: - IBOutlet Property
    /// 图片
    @IBOutlet weak var imgIcon: xWebImageView!

    // MARK: - Public Property
    var setImageHandler : xHandlerSetImageCompleted?
    /// 网络图片
    var webImage = ""
    /// 本地图片
    var locImage : UIImage?
    
    // MARK: - 内存释放
    deinit {
        self.setImageHandler = nil
        
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("🥚【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    open override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(xib: nil)
        return vc
    }
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
        self.view.backgroundColor = .clear
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let img = self.locImage {
            self.imgIcon.image = img
            self.setImageHandler?(img)
        } else {
            self.imgIcon.xSetWebImage(url: self.webImage) {
                [weak self] (img) in
                guard let self = self else { return }
                self.setImageHandler?(img)
            }
        }
    }

    // MARK: - 添加回调
    /// 添加回调
    public func addSetImageCompleted(_ handler : @escaping xPageItemImage.xHandlerSetImageCompleted)
    {
        self.setImageHandler = handler
    }
}
