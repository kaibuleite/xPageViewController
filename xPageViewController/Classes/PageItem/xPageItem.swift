//
//  xPageItem.swift
//  xPageViewController
//
//  Created by Mac on 2023/3/30.
//

import UIKit
import xKit

open class xPageItem: UIViewController {
    
    // MARK: - Public Property 
    var typeEmoji : String { return "🥚" }
    
    // MARK: - 内存释放
    deinit {
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        let type = self.typeEmoji
        print("\(type)_\(self.view.tag)【\(space).\(name)】")
    }
    
    // MARK: - Override Func
    open override class func xDefaultViewController() -> Self {
        let vc = Self.xNew(xib: nil)
        return vc
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            self.addKit()
            self.addChildren()
            self.requestData()
        }
    }
    
}
