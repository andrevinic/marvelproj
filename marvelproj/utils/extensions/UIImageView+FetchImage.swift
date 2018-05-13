//
//  UIImageView+Alamofire.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
class ImageCache{
    
    // MARK: - CACHE Images
    let imageCache = NSCache<NSString, UIImage>()

    // MARK: - Singleton
    static let shared : ImageCache = ImageCache()

    func image(url: String)->UIImage?{
        
        guard let cachedImage = imageCache.object(forKey: url as NSString) else{
            return nil
        }
        
        return cachedImage
    }
    
    func cacheImage(image: UIImage, forKey: NSString){
        self.imageCache.setObject(image, forKey: forKey)
    }
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self?.image = image
                ImageCache.shared.cacheImage(image: image, forKey: url.absoluteString as NSString)
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        
        if let image = ImageCache.shared.image(url: link){ self.image = image } else{
            self.image = UIImage(named: "marvel_screen")
            downloadedFrom(url: url, contentMode: mode)
        }
    }

}

extension UIImageView{
    func setCircularImageView() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.marvel.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true

    }
}



