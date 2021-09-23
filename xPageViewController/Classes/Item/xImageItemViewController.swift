//
//  xImageItemViewController.swift
//  Alamofire
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xWebImage

class xImageItemViewController: UIViewController {

    // MARK: - IBOutlet Property
    /// 图片
    @IBOutlet weak var imgIcon: xWebImageView!

    // MARK: - Public Property
    /// 网络图片
    var webImage = ""
    /// 本地图片
    var locImage : UIImage?
    
    // MARK: - 内存释放
    deinit {
        print("🥚 \(self.xClassInfoStruct.name)")
    }
    
    // MARK: - Override Func
    override class func xDefaultViewController() -> Self
    {
        let bundle = Bundle.init(for: self.classForCoder())
        let vc = xImageItemViewController.init(nibName: "xImageItemViewController", bundle: bundle)
        return vc as! Self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let img = self.locImage {
            self.imgIcon.image = img
        }
        else {
            self.imgIcon.xSetWebImage(url: self.webImage)
        }
    }

}
