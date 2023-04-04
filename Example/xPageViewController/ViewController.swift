//
//  ViewController.swift
//  xPageViewController
//
//  Created by 177955297@qq.com on 06/21/2021.
//  Copyright (c) 2021 177955297@qq.com. All rights reserved.
//

import UIKit
import xKit
import xWebImage
import xPageViewController

class ViewController: xViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentHeightLayout: NSLayoutConstraint!
    
    // MARK: - Public Property
    var vcList = [xPageItem]()
    var locImgList = [UIImage]()
    var webImgList = [String]()
    
    // MARK: - Child
    let childPage = xPageViewController.xDefaultViewController()
    let childPictures = xPagePicturesViewController.xDefaultViewController()
    let childPreviewPictures = xPagePreviewPicturesViewController.xDefaultViewController()
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        xWebImageManager.clearSDWebImageCache {
            
        }
        self.view.backgroundColor = .groupTableViewBackground
        self.titleLbl.text = "-"
        for _ in 0 ..< 5 {
            let vc = xPageItem()
            vc.view.backgroundColor = .xNewRandom(alpha: 0.8)
            self.vcList.append(vc)
        }
        for i in 0 ..< 10 {
            guard let img = "IMG_\(i)".xToImage() else { continue }
            self.locImgList.append(img)
        }
        let arr = [
            "000/000/020/61aad27cbf838540.jpg",
            "000/000/020/6217328dbd59c168.jpg",
            "000/000/020/61cbb211eeb87714.jpg",
            "000/000/004/61a1a8cf99f6f430.jpg",
            "000/000/020/61ef957e5bb3c333.jpg",
            "000/000/020/61efa3ff06cdf865.jpg",
            "000/000/020/61ef8c737e135297.jpg",
            "000/000/012/61ee450bc117f794.jpg",
            "000/000/009/612843eb4155b234.jpg",
            "000/000/012/61a9be818b47c738.jpg",
            "000/000/020/6251475a1371d738.png",
            "000/000/020/621733df73b9e366.jpg",
            "000/000/020/6217339ab3eb1658.jpg",
            "000/000/012/6172136e58dbd764.jpg",
            "000/000/012/618f4ef5bf569353.jpg",
            "000/000/004/617be43a47328749.jpg",
            "000/000/004/61a07831dbef1321.jpg",
            "000/000/009/61285d882042c236.png",
            "000/000/012/6275e85d7926f817.png",
            "000/000/020/625a77234cb26665.jpg",]
        for str in arr {
            self.webImgList.append("https://mall-fudouzhongkang.oss-cn-shenzhen.aliyuncs.com/upload/group/\(str)")
        }
        
        self.childPage.isOpenAutoChangeTimer = true
        self.childPage.changeInterval = 8
        self.childPage.addChangePage {
            [weak self] (page) in
            guard let self = self else { return }
            self.titleLbl.text = "\(page + 1)/\(self.childPage.totalPage)"
        }
        self.childPage.addClickPage {
            (page) in
            print("点击第\(page)页")
        }
        
        self.childPictures.addClickPage  {
            (page) in
            print("点击第\(page)张图片")
        }
        self.childPictures.addLoadCompleted {
            [weak self] (min, max) in
            guard let self = self else { return } 
            self.contentHeightLayout.constant = min
            self.childContainer?.setNeedsLayout()
            self.childContainer?.layoutIfNeeded() 
        }
    }
    override func addChildren() {
        self.childPage.view.alpha = 0
        self.xAddChild(viewController: self.childPage, in: self.childContainer!)
        self.childPictures.view.alpha = 0
        self.xAddChild(viewController: self.childPictures, in: self.childContainer!)
        self.childPreviewPictures.view.alpha = 0
        self.xAddChild(viewController: self.childPreviewPictures, in: self.childContainer!)
        // 预览在内部主线程添加xPage控件，如果这里刷新数据会导致大小不对
    }

    // MARK: - Button
    @IBAction func pageBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.contentHeightLayout.constant = 300
        self.childContainer?.setNeedsLayout()
        self.childContainer?.layoutIfNeeded()
        
        self.titleLbl.isHidden = false
        self.childPage.view.alpha = 1
        self.childPage.openTimer()
        self.childPage.reload(itemViewControllerArray: self.vcList)
        
        self.childPictures.view.alpha = 0
        self.childPreviewPictures.view.alpha = 0
    }
    @IBAction func pagePicBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.titleLbl.isHidden = true
        self.childPage.view.alpha = 0
        self.childPage.closeTimer()
        
        self.childPictures.view.alpha = 1
        self.childPictures.reload(webImageArray: self.webImgList)
        self.childPreviewPictures.view.alpha = 0
    }
    @IBAction func pagePreviewPicBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.contentHeightLayout.constant = 500
        self.childContainer?.setNeedsLayout()
        self.childContainer?.layoutIfNeeded()
        
        self.titleLbl.isHidden = true
        self.childPage.view.alpha = 0
        self.childPage.closeTimer()
        
        self.childPictures.view.alpha = 0
        self.childPreviewPictures.view.alpha = 1
        self.childPreviewPictures.reload(locImageArray: self.locImgList)
    }
}

