//
//  Character.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
typealias Codable = Decodable & Encodable

protocol Details{
    var title: String? {get set}
    var description: String? {get set}
    var thumbnail: Thumbnail? {get set}
}

struct Character: Codable{
    let id: Int
    let name: String
    let description: String
//    let thumbnail: Thumbnail
}

struct test: Decodable{
    var id:Int
}
//extension Character{
//    init?(json: [String: Any]) {
//
//        if let id = json["id"] as? Int{
//            self.id = id
//        }
//        if let name = json["name"] as? String{
//            self.name = name
//        }
//        if let description = json["description"] as? String{
//            self.description = description
//        }
//
//        if let thumbnail = json["thumbnail"] as? [String:Any]{
//            self.thumbnail = Thumbnail(json: thumbnail)
//        }
//
//    }
//}

//extension Character: Equatable{
//    static func == (lhs: Character, rhs: Character) -> Bool{
//        return lhs.id == rhs.id
//    }
//}

