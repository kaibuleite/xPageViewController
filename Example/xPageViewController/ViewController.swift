//
//  ViewController.swift
//  xPageViewController
//
//  Created by 177955297@qq.com on 06/21/2021.
//  Copyright (c) 2021 177955297@qq.com. All rights reserved.
//

import UIKit
import xKit
import xPageViewController

class ViewController: xViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var titleLbl: UILabel!
    
    // MARK: - Public Property
    var imgList = [UIImage]()
    
    // MARK: - Child
    let childPage = xPageViewController.xDefaultViewController()
    let childPreviewPic = xPagePreviewPicturesViewController.xDefaultViewController()
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.titleLbl.text = ""
        var list = [UIImage]()
        for i in 0 ..< 10 {
            guard let img = "IMG_\(i)".xToImage() else { continue }
            list.append(img)
        }
        self.imgList = list
        
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
    }
    /*
    override func addKit() {
        DispatchQueue.main.async {
            print("addKit_1")
            DispatchQueue.main.async {
                print("addKit_1_1")
            }
            DispatchQueue.main.async {
                print("addKit_1_2")
            }
            DispatchQueue.main.async {
                print("addKit_1_3")
                DispatchQueue.main.async {
                    print("addKit_1_3_1")
                }
                DispatchQueue.main.async {
                    print("addKit_1_3_2")
                }
            }
        }
        DispatchQueue.main.async {
            print("addKit_2")
            DispatchQueue.main.async {
                print("addKit_2_1")
            }
            DispatchQueue.main.async {
                print("addKit_2_1")
            }
        }
        DispatchQueue.main.async {
            print("addKit_3")
            DispatchQueue.main.async {
                print("addKit_3_1")
                DispatchQueue.main.async {
                    print("addKit_3_1_1")
                }
                DispatchQueue.main.async {
                    print("addKit_3_1_2")
                }
            }
        }
    }
     */
    override func addChildren() {
        self.childPage.view.alpha = 0
        self.xAddChild(viewController: self.childPage, in: self.childContainer!)
        self.childPreviewPic.view.alpha = 0
        self.xAddChild(viewController: self.childPreviewPic, in: self.childContainer!)
        // 预览在内部主线程添加xPage控件，如果这里刷新数据会导致大小不对
    }

    // MARK: - Button
    @IBAction func pageBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.titleLbl.isHidden = false
        self.childPage.view.alpha = 1
        self.childPage.openTimer()
        self.childPreviewPic.view.alpha = 0
        self.childPage.reload(locImageArray: self.imgList)
    }
    @IBAction func pagePreviewPicBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.titleLbl.isHidden = true
        self.childPage.view.alpha = 0
        self.childPage.closeTimer()
        self.childPreviewPic.view.alpha = 1
        self.childPreviewPic.reload(locImageArray: self.imgList, select: 0)
    }
}

