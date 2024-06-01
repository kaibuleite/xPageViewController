//
//  xWebImageManager.swift
//  xWebImage
//
//  Created by Mac on 2021/6/11.
//

import Foundation
import xExtension
import Photos
import SDWebImage

public class xWebImageManager: NSObject {
    
    // MARK: - Public Property
    /// 单例
    public static let shared = xWebImageManager()
    private override init() { }
    /// 网络图通用前缀
    public var webImageURLPrefix = "http"
    /// 占位图
    public var placeholderImage = UIColor.xNew(hex: "F5F5F5").xToImage(size: .init(width: 5, height: 5))
    
    // MARK: - SD框架缓存
    /// SD框架图片缓存大小
    /// - Returns: 缓存大小
    public static func getSDWebImageCacheSize() -> CGFloat
    {
        let size = SDImageCache.shared.totalDiskSize()
        // 换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
        let mb : CGFloat = CGFloat(size) / 1000 / 1000
        return mb
    }
    
    /// 清理SD框架图片缓存
    /// - Parameter handler: 清理完成回调
    public static func clearSDWebImageCache(completed handler : @escaping () -> Void)
    {
        SDImageCache.shared.clear(with: .all) {
            print("清理完成")
            handler()
        }
    }
    
    /// 从缓存中获取图片
    /// - Parameter key: 图片url
    /// - Returns: 图片
    public static func getSDCacheImage(forKey key: String) -> UIImage?
    {
        let mgr = SDImageCache.shared
        // 从缓存里找
        if let img = mgr.imageFromCache(forKey: key) { return img}
        // 从内存里找
        if let img = mgr.imageFromMemoryCache(forKey: key) { return img }
        // 从磁盘里找
        if let img = mgr.imageFromDiskCache(forKey: key) { return img }
        // 找不到
        return nil
    }
    
    // MARK: - SD框架图片加载
    /// 下载图片
    /// - Parameters:
    ///   - url: 图片url
    ///   - handler1: 下载中回调
    ///   - handler2: 下载完成回调
    public static func downloadImage(url : String,
                                     progress handler1 : @escaping SDWebImageDownloaderProgressBlock,
                                     completed handler2 : @escaping SDWebImageDownloaderCompletedBlock)
    {
        let op1 = SDWebImageDownloaderOptions.highPriority
        let op2 = SDWebImageDownloaderOptions.scaleDownLargeImages
//        let op3 = SDWebImageDownloaderOptions.avoidDecodeImage
//        let options = SDWebImageDownloaderOptions.init(rawValue: op1.rawValue | op2.rawValue | op3.rawValue)
        let options = SDWebImageDownloaderOptions.init(rawValue: op1.rawValue | op2.rawValue)
        /*
         下载中图片的加载
         let source = CGImageSourceCreateIncremental(nil) // 创建一个空的图片源，随后在获得新数据时调用
         CGImageSourceUpdateData(source, <#T##data: CFData##CFData#>, false) // 更新图片源
         CGImageSourceCreateImageAtIndex(source, 0, nil) // 创建图片
         */
        SDWebImageDownloader.shared.downloadImage(with: url.xToURL(),
                                                  options: options,
                                                  progress: handler1,
                                                  completed: handler2)
    }
}

extension SDImageFormat {
    
    /// 获取图片类型名称
    /// - Returns: 获取图片类型名称
    public func xGetImageTypeName() -> String
    {
        switch self {
        case .JPEG:     return "jpg" // jpeg
        case .PNG:      return "png"
        case .GIF:      return "gif"
        case .TIFF:     return "tiff" // tif
        case .webP:     return "webp"
        case .HEIC:     return "heic"
        case .HEIF:     return "heif"
        case .PDF:      return "pdf"
        case .SVG:      return "svg"
        default:        return "unknown"
        }
    }
}
