//
//  MarvelService.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

struct KeyDict {
    let publicKey: String!
    let privateKey: String!
}

class MarvelService: NSObject {
    
    class func getKeys() -> KeyDict {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "strings", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)!
        }
        
        if let data = keys {
            return KeyDict(publicKey: data["publicKey"] as! String, privateKey: data["privateKey"] as! String)
        } else {
            return KeyDict(publicKey: "", privateKey: "")
        }
    }
    class func getCharacteresURL() -> String{
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "strings", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)!
        }
        
        if let data = keys {
            return data["characteres"] as! String
        }
        return ""
    }
}

