//
//  Stories.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import ObjectMapper

struct Story{

    var id: Int?
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
}

extension Story: Mappable{
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.description <- map["description"]
        self.thumbnail <- map["thumbnail"]
    }
}
