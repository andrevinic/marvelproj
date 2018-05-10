//
//  Thumbnail.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

struct Thumbnail{
    
    var tExtension: String = ""
    var path: String = ""
}

extension Thumbnail{
    init?(json: [String: Any]) {
        guard let tExtension = json["extension"] as? String,
            let path = json["path"] as? String
            else{
                return nil
        }
        self.tExtension = tExtension
        self.path = path
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
