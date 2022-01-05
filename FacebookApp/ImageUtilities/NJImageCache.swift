//
//  NJImageCache.swift
//  FacebookApp
//
//  Created by joehsieh on 2022/01/05.
//  Copyright © 2022 NJ. All rights reserved.
//

import Foundation
import UIKit

protocol NJImageCacheProtocol {
    func setImage(_ image: UIImage?, for url: URL)
    func image(for url: URL) -> UIImage?
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ url: URL) -> UIImage? { get set }
}


final class NJImageCache {
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 100 * 1024 * 1024)
    }
    
    private let lock = NSLock()

    private let config: Config
    
    init(with config: Config = .defaultConfig) {
        self.config = config
    }
    
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
}

extension NJImageCache: NJImageCacheProtocol {
    func setImage(_ image: UIImage?, for url: URL) {
        guard let image = image else {
            removeImage(for: url)
            return
        }
        let decodedImage = image.decodedImage()
        lock.lock()
        defer { lock.unlock() }
        imageCache.setObject(image, forKey: url as AnyObject)
        decodedImageCache.setObject(decodedImage, forKey: url as AnyObject)
    }
    
    func image(for url: URL) -> UIImage? {
        lock.lock()
        defer { lock.unlock() }
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(decodedImage, forKey: url as AnyObject)
            return decodedImage
        }
        return nil
    }
    
    func removeImage(for url: URL) {
        lock.lock()
        defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImages() {
        lock.lock()
        defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    subscript(url: URL) -> UIImage? {
        get {
            image(for: url)
        }
        set {
            setImage(newValue, for: url)
        }
    }
    
    
}


extension UIImage {
    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }
}
