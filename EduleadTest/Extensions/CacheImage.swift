//
//  CacheImage.swift
//  EduleadTest
//
//  Created by Camilo Cabana on 2/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import Foundation

import UIKit

extension UIImageView {
    
    func loadCacheImage(_ vc: UIViewController, url: String) {
        let imageCache = NSCache<NSString, UIImage>()
        self.image = nil
        if let cahedImage = imageCache.object(forKey: url as NSString) {
            self.image = cahedImage
            return
        }
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                if let error = error {
                    let alert = Alert()
                    alert.errorAlert(vc, title: "System", messege: "error: \(error)")
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: url as NSString)
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
