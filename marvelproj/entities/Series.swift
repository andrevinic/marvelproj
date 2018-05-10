//
//  Series.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

struct Series {
    var id: Int?
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
}

extension Series{
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let thumbnail = json["thumbnail"] as? [String:Any]
            else{
                return nil
        }
        
        self.id = id
        self.description = description
        self.title = title
        self.thumbnail = Thumbnail(json: thumbnail)
    }
}
