//
//  KingFisher+ImageView.swift
//  marvelproj
//
//  Created by André Nogueira on 9/29/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func download(image url: String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        self.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}
