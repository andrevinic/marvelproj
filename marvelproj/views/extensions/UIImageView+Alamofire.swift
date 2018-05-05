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
