//
//  Comics.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

struct Comics: Details, Codable{
    
    var id: Int?
    var title: String?
    var description: String?
    var thumbnail: Thumbnail?
    
    private enum CodingKeys: String, CodingKey{
        case id
        case title
        case description
        case thumbnail
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
//        try container.encode(thumbnail, forKey: .thumbnail)
    }
    
}
