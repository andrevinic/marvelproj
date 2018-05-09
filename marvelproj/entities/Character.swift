//
//  Character.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
//import ObjectMapper

struct Character{
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: Thumbnail?
    var comics: ComicsCharacter?
    var stories: StoriesCharacter?
}

//extension Character: Mappable{
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        self.id <- map["id"]
//        self.name <- map["name"]
//        self.description <- map["description"]
//        self.thumbnail <- map["thumbnail"]
//        self.comics <- map["comics"]
//        self.stories <- map["stories"]
//    }
//}

extension Character{
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int,
            let description = json["description"] as? String,
            let thumbnail = json["thumbnail"] as? [String:Any],
            let comics = json["comics"] as? [String: Any]
        else{
            return nil
        }
        
        self.name = name
        self.id = id
        self.description = description
        self.thumbnail = Thumbnail(json:thumbnail)
        self.comics = ComicsCharacter(json: comics)
    }
}
