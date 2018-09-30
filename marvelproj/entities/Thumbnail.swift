//
//  Thumbnail.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit


struct Thumbnail: Decodable{
    
    var tExtension: String = ""
    var path: String = ""
    
    private enum CodingKeys: String, CodingKey{
        case tExtension = "extension"
        case path = "path"
    }
    
}


extension Thumbnail{
    func securePath() -> String {
        if self.path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
    func fullPath() -> String{
        return self.securePath() + "." + self.tExtension
    }
    
}
