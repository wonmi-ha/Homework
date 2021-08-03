//
//  ImageCacheManager.swift
//  Homework
//
//  Created by 하원미 on 2021/08/03.
//  Copyright © 2021 하원미. All rights reserved.
//

import Foundation
import UIKit

private var manager: ImageCacheManager?

class ImageCacheManager {
    
    private var dictionaryImageCache: Dictionary<String, UIImage> = [String:UIImage]()

    public static let shared: ImageCacheManager = {
        if (manager == nil) {
            manager = ImageCacheManager()
        }

        return manager!
    }()

    private init() { }
    
    public func getCache(_ urlPath: String) -> UIImage? {
        return dictionaryImageCache[urlPath]
    }
    
    public func setCache(_ urlPath: String, image: UIImage?) {
        dictionaryImageCache[urlPath] = image
    }
}
