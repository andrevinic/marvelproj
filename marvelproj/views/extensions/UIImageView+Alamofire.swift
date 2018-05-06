//
//  UIImageView+Alamofire.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView{
    
    func download(url: String){
        guard let url = URL(string: url) else{
            return
        }
        self.af_setImage(withURL: url)
    }
}

extension UIImageView{
    func setCircularImageView() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
//        self.layer.cornerRadius = CGFloat(roundf(Float(self.frame.size.height / 2.0)))
//        self.layer.cornerRadius = CGFloat(roundf(Float(self.frame.size.height / 2.0)))
    }
}
