//
//  EventsCharacter.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

struct EventsCharacter{
    var collectionURI: String?
    var available: Int?
}

extension EventsCharacter{
    init?(json: [String: Any]) {
        guard let collectionURI = json["collectionURI"] as? String,
            let available = json["available"] as? Int
            else{
                return nil
        }
        
        self.collectionURI = collectionURI
        self.available = available
    }
}
