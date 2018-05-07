//
//  StoriesCharacter.swift
//  marvelproj
//
//  Created by Andre Nogueira on 07/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import ObjectMapper

struct StoriesCharacter{
    var collectionURI: String?
    var available: Int?
}

extension StoriesCharacter: Mappable{
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.collectionURI <- map["collectionURI"]
        self.available <- map["available"]
    }
}
extension StoriesCharacter{
    
    func securePath() -> String {
        let url = self.collectionURI!
        if (url.hasPrefix("http://")) {
            let range = url.range(of: "http://")
            var newPath = url
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return url
        }
    }
}
