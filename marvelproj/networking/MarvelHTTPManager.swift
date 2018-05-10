//
//  MarvelHTTPManager.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelHTTPManager: NSObject {
    
    func parseToComics(jsonWithObjectRoot: [String: Any])->[Comics]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var comics = [Comics]()
        for item in results{
            if let comic = Comics(json: item){
                comics.append(comic)
            }
        }
        return comics
    }
    
    func parseToCharacters(jsonWithObjectRoot: [String: Any])->[Character]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var characters = [Character]()
        for item in results{
            if let char = Character(json: item){
                characters.append(char)
            }
        }
        return characters
    }
    
    func removeWrappers(jsonWithObjectRoot: [String:Any])->[[String:Any]]{
        if let datadictionary = try? jsonWithObjectRoot["data"] as! [String: Any]{
            let results = datadictionary["results"] as? [[String: Any]]
            return results!
        }
        return [jsonWithObjectRoot]
        
    }
}

