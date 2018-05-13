//
//  Character.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
protocol Details{
    var title: String? {get set}
    var description: String? {get set}
    var thumbnail: Thumbnail? {get set}
}

struct Character{
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: Thumbnail?

}

extension Character{
    init?(json: [String: Any]) {
        
        if let id = json["id"] as? Int{
            self.id = id
        }
        if let name = json["name"] as? String{
            self.name = name
        }
        if let description = json["description"] as? String{
            self.description = description
        }
        
        if let thumbnail = json["thumbnail"] as? [String:Any]{
            self.thumbnail = Thumbnail(json: thumbnail)
        }
        
    }
}

