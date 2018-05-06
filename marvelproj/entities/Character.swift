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
    
}

