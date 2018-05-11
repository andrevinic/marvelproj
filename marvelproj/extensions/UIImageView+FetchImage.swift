//
//  UIImageView+Alamofire.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
class ImageCache{
    let imageCache = NSCache<NSString, UIImage>()
    static let shared : ImageCache = ImageCache()

    func image(url: URL, completion: @escaping (UIImage?) -> Void ){
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        }
    }
    init() {
        
    }
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder               // use placeholder (or if `nil`, remove any old image, before initiating asynchronous retrieval
        ImageCache.shared.image(url: url) { (image) in
            self.image = image
        }
//        ImageCache.shared.image(url: url) { [weak self] result in
//            switch result {
//            case .success(let image):
//                self?.image = image
//
//            case .failure:
//                break
//            }
//        }
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



