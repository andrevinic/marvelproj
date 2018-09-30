//
//  Character.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

protocol Details: Codable{
    var title: String? {get set}
    var description: String? {get set}
    var thumbnail: Thumbnail? {get set}
}

struct Character: Codable{
    
    var id: Int = 0
    var  name: String = ""
    var description: String = ""
    var thumbnail: Thumbnail?

    private enum CodingKeys: String, CodingKey{
        case id
        case name
        case description
        case thumbnail
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
    }
}
extension Character{

    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        thumbnail = try values.decode(Thumbnail.self, forKey: .thumbnail)
    }
}


extension Character: Equatable{
    static func == (lhs: Character, rhs: Character) -> Bool{
        return lhs.id == rhs.id
    }
}

