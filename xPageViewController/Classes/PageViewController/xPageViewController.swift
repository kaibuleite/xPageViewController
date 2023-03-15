//
//  xPageViewController.swift
//  xSDK
//
//  Created by Mac on 2020/9/21.
//

import UIKit
import xExtension

public class xPageViewController: UIPageViewController {

    // MARK: - Enum
    /// 拖拽方向
    public enum xDraggingDirection {
        /// 下一个
        case next
        /// 上一个
        case previous
    }
    
    // MARK: - Struct
    public struct xDraggingData {
        /// 从哪页来
        public var fromPage = 0
        /// 到哪页去
        public var toPage = 0
        /// 滚动进度
        public var progress = CGFloat.zero
    }
    
    // MARK: - Handler
    /// 切换页数
    public typealias xHandlerChangePage = (Int) -> Void
    /// 滚动中
    public typealias xHandlerScrolling = (xDraggingData, xDraggingDirection) -> Void
    /// 点击分页
    public typealias xHandlerClickPage = (Int) -> Void
    
    // MARK: - Public Property
    /// 刷新频率(默认5s)
    public var changeInterval = TimeInterval(5)
    /// 是否开启定时器
    public var isOpenAutoChangeTimer = true
    /// 是否可以滚动
    public var isScrollEnable = true
    /// 是否拖拽中
    public var isDragging = false

    // MARK: - Private Property
    /// 总页数
    public var totalPage = 0
    /// 当前页数编号
    var currentPage = 0
    /// 目标页数编号
    var pendingPage = 0
    /// 定时器
    var timer : Timer?
    /// 滚动容器
    var contentScrollView : UIScrollView?
    /// 单页子控制器
    var itemArray = [UIViewController]()
    /// 滚动回调
    var scrollingHandler : xHandlerScrolling?
    /// 切换回调
    var changeHandler : xHandlerChangePage?
    /// 点击回调
    var clickHandler : xHandlerClickPage?
    
    // MARK: - 内存释放
    deinit {
        self.closeTimer()
        self.delegate = nil
        self.dataSource = nil
        self.contentScrollView?.delegate = nil
        self.scrollingHandler = nil
        self.changeHandler = nil
        self.clickHandler = nil
        
        let info = self.xClassInfoStruct
        let space = info.space
        let name = info.name
        print("🐔【\(space).\(name)】")
    }

    // MARK: - Public Override Func
    /// 实例化对象
    /// - Parameter transition: 换页方式
    /// - Parameter orientation: 滚动方向
    /// - Returns: 实例化对象
    public class func xDefaultViewController(transition style : UIPageViewController.TransitionStyle,
                                             navigation orientation: UIPageViewController.NavigationOrientation) -> Self
    {
        let vc = xPageViewController.init(transitionStyle: style, navigationOrientation: orientation)
        return vc as! Self
    }
    public override class func xDefaultViewController() -> Self
    {
        let vc = Self.xNew(storyboard: nil)
        return vc
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        self.view.backgroundColor = .clear
        // 绑定滚动容器
        for obj in self.view.subviews {
            guard let scrol = obj as? UIScrollView else { continue }
            self.contentScrollView = scrol
            break
        }
        // 关联代理
        self.dataSource = self
        self.delegate = self
        self.contentScrollView?.delegate = self
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard self.isOpenAutoChangeTimer else { return }
        self.openTimer()
    }
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.closeTimer()
    }
    
    // MARK: - 添加回调
    public func addScrollingPage(_ handler : @escaping xPageViewController.xHandlerScrolling)
    {
        self.scrollingHandler = handler
    }
    public func addChangePage(_ handler : @escaping xPageViewController.xHandlerChangePage)
    {
        self.changeHandler = handler
    }
    public func addClickPage(_ handler : @escaping xPageViewController.xHandlerClickPage)
    {
        self.clickHandler = handler
    }
    
}
