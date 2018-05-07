//
//  Character.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import ObjectMapper

struct Character{
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: Thumbnail?
    var comics: ComicsCharacter?
    var stories: StoriesCharacter?
}

extension Character: Mappable{
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.thumbnail <- map["thumbnail"]
        self.comics <- map["comics"]
        self.stories <- map["stories"]
    }
}


struct ComicsCharacter{
    var collectionURI: String?
    var available: Int?
}
extension ComicsCharacter: Mappable{
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.collectionURI <- map["collectionURI"]
        self.available <- map["available"]
    }
    
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

