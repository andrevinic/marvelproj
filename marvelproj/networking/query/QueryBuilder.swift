//
//  QueryBuilder.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class QueryBuilder: NSObject {
    
    let base_URL = "gateway.marvel.com"
    let character_ext = "/v1/public/characters"
    static let shared : QueryBuilder = QueryBuilder()
    
}

extension QueryBuilder{
    
    func query(ts: String, apikey: String, hash: String, offset: String, path: String)->String{
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
}

extension QueryBuilder{
    func query(ts: String, apikey: String, hash: String, characterID: Int)->String{
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
}

extension QueryBuilder{
    func query(ts: String, apikey: String, hash: String, nameStartsWith: String, path: String)->String{
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
}
