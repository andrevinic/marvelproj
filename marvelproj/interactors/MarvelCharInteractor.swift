//
//  MarvelCharInteractor.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import CryptoSwift
import ObjectMapper
import SwiftyJSON

class MarvelCharInteractor: NSObject {

    
    func fetchCharacteres(limit: Int, offset: Int, completion: @escaping (_ characters: [Character], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        
        let ts = NSDate().timeIntervalSince1970.description
        let charactersURL = MarvelService.getCharacteresURL()
        
        let parametros : Parameters = [
            "apikey" : dict.publicKey,
            "ts" : ts,
            "hash" : (ts + dict.privateKey + dict.publicKey).md5() ,
            "orderBy" : "name",
            "limit" : limit,
            "offset" : offset,
        ]
        
        Alamofire.request(charactersURL, parameters: parametros).responseJSON{ response in
            switch response.result{
            case .failure(let error):
                return
            case .success(let data):
                let jsonResult = JSON(response.result.value!)
                let charactersJSON = self.removeWrappers(json: jsonResult)
                let chars = Mapper<Character>().mapArray(JSONString: charactersJSON.rawString()!)
                completion(chars!, nil)
            }
        }
    }
    
    func fetchSearchByNameStartsWith(nameStartsWith: String, completion: @escaping (_ characters: [Character], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let charactersURL = MarvelService.getCharacteresURL()
        let parametros : Parameters = [
            "apikey" : dict.publicKey,
            "ts" : ts,
            "hash" : (ts + dict.privateKey + dict.publicKey).md5() ,
            "orderBy" : "name",
            "nameStartsWith" : nameStartsWith,
            ]
        Alamofire.request(charactersURL, parameters: parametros).responseJSON{ response in
            switch response.result{
            case .failure(let error):
                return
            case .success(let data):
                let jsonResult = JSON(response.result.value!)
                let charactersJSON = self.removeWrappers(json: jsonResult)
                let chars = Mapper<Character>().mapArray(JSONString: charactersJSON.rawString()!)
                completion(chars!, nil)
            }
        }
        
    }
    
    func fetchStories(storiesURL: String, completion: @escaping (_ stories: [Story], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let parametros : Parameters = [
            "apikey" : dict.publicKey,
            "ts" : ts,
            "hash" : (ts + dict.privateKey + dict.publicKey).md5() ,
            "orderBy" : "id",
            ]
        
        Alamofire.request(storiesURL, parameters: parametros).responseJSON{ response in
            switch response.result{
            case .failure(let error):
                return
            case .success(let data):
                let jsonResult = JSON(response.result.value!)
                let storiesJSON = self.removeWrappers(json: jsonResult)
                let stories = Mapper<Story>().mapArray(JSONString: storiesJSON.rawString()!)
                completion(stories!, nil)
            }
        }
    }
    
    func fetchComics(comicsURL: String, completion: @escaping (_ comics: [Comics], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let parametros : Parameters = [
            "apikey" : dict.publicKey,
            "ts" : ts,
            "hash" : (ts + dict.privateKey + dict.publicKey).md5() ,
            "orderBy" : "title",
            ]
        
        Alamofire.request(comicsURL, parameters: parametros).responseJSON{ response in
            switch response.result{
            case .failure(let error):
                return
            case .success(let data):
                let jsonResult = JSON(response.result.value!)
                let comicsJSON = self.removeWrappers(json: jsonResult)
                let comics = Mapper<Comics>().mapArray(JSONString: comicsJSON.rawString()!)
                completion(comics!, nil)
            }
        }
    }
    func removeWrappers(json: JSON) -> JSON{
        let arrayjson = json.dictionary!["data"]!["results"]
        return arrayjson
    }
}
