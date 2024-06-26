//
//  ViewController+xNew.swift
//  xExtension
//
//  Created by Mac on 2021/6/10.
//

import Foundation

extension UIViewController {
    
    /// 实例化默认视图控制器
    /// - Returns: 实例化对象
    @objc open class func xDefaultViewController() -> Self
    {
        let vc = UIViewController()
        return vc as! Self
    }
    
    /// 通过storyboard实例化
    /// - Parameters:
    ///   - name: storyboard名称，传nil则跟当前类相同名称
    ///   - identifier: 身份标识
    /// - Returns: 实例化对象
    public class func xNew(storyboard name : String? = nil,
                           identifier : String = "") -> Self
    {
        let bundle = Bundle.init(for: self.classForCoder())
        var str = name ?? ""
        if str.count == 0 {
            str = self.xClassInfoStruct.name
        }
        let sb = UIStoryboard.init(name: str, bundle: bundle)
        if identifier.count == 0 {
            let vc = sb.instantiateInitialViewController()
            return vc as! Self
        }
        else {
            let vc = sb.instantiateViewController(withIdentifier: identifier)
            return vc as! Self
        }
    }
    /// 通过storyboard实例化
    /// - Parameters:
    ///   - name: storyboard名称，传nil则跟当前类相同名称
    ///   - identifier: 身份标识
    /// - Returns: 实例化对象
    public class func xNewStoryboard(name : String? = nil,
                                     identifier : String = "") -> Self
    {
        return self.xNew(storyboard: name, identifier: identifier)
    }
    
    /// 通过xib实例化
    /// - Parameters:
    ///   - name: xib名称，传nil则跟当前类相同名称
    /// - Returns: 实例化对象
    public class func xNew(xib name : String? = nil) -> Self
    {
        var str = name ?? ""
        if str.count == 0 {
            str = self.xClassInfoStruct.name
        }
        let bundle = Bundle.init(for: self.classForCoder())
        return Self.init(nibName: str, bundle: bundle)
    }
    /// 通过xib实例化
    /// - Parameters:
    ///   - name: xib名称，传nil则跟当前类相同名称
    /// - Returns: 实例化对象
    public class func xNewXib(name : String? = nil) -> Self
    {
        return self.xNew(xib: name)
    }
    
}
