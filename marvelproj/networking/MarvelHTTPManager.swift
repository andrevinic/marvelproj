//
//  MarvelHTTPManager.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelHTTPManager: NSObject {
    
    var queryItems: [URLQueryItem]?
    let base_URL = "gateway.marvel.com"
    
    let character_ext = "/v1/public/characters"
   
    func queryBuilder(ts: String, apikey: String, hash: String, characterID: Int)->String{
        var url = URLComponents()
        url.scheme = "https"
        url.host = self.base_URL
        url.path = character_ext + "/\(characterID)/comics"
        
        url.queryItems = [
            URLQueryItem(name:"ts", value:ts),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "hash", value: hash),
        ]
        
        return url.string!
    }
    
    func queryBuilder(ts: String, apikey: String, hash: String, nameStartsWith: String, path: String)->String{
        var url = URLComponents()
        url.scheme = "https"
        url.host = self.base_URL
        url.path = path
        
        url.queryItems = [
            URLQueryItem(name:"ts", value:ts),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "nameStartsWith", value:nameStartsWith)
        ]
        
        return url.string!
    }
    
    func queryBuilder(ts: String, apikey: String, hash: String, offset: String, path: String)->String{
        var url = URLComponents()
        url.scheme = "https"
        url.host = self.base_URL
        url.path = path
        
        url.queryItems = [
            URLQueryItem(name:"ts", value:ts),
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "offset", value:offset)
        ]
        
        return url.string!
    }
    
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

protocol QueryBuilder{
    //    func queryBuilder(ts: String, apikey: String, hash: String, offset: String, path: String)->String
    func queryBuilderCharacter(ts: String, apikey: String, hash: String, offset: String, path: String)->String
    func queryBuilderSearchCharacter(ts: String, apikey: String, hash: String, startsNameWith: String, path: String)->String
    func queryBuilderComics(ts: String, apikey: String, hash: String,path: String)
}
//class QueryBuilder: Query{
//    func queryBuilder(ts: String, apikey: String, hash: String, offset: String, path: String)->String{
//        return ""
//    }
//}

