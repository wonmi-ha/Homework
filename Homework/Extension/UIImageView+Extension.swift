//
//  UIImageView+Extension.swift
//  Homework
//
//  Created by 하원미 on 2021/08/03.
//  Copyright © 2021 하원미. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(_ urlPath: String) {
        if let image = ImageCacheManager.shared.getCache(urlPath) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
        else {
            if let url = URL(string: urlPath) {
                DispatchQueue.global(qos: .background).async {
                    URLSession.shared.dataTask(with: url) { (data, res, err) in
                        if let _ = err {
                            DispatchQueue.main.async {
                                self.image = UIImage()
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data, let image = UIImage(data: data) {
                                ImageCacheManager.shared.setCache(urlPath, image: image)
                                self.image = image
                            }
                        }
                    }.resume()
                }
            }
        }
   }
}
