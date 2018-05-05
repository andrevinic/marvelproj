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
    
    func removeWrappers(json: JSON) -> JSON{
        let arrayjson = json.dictionary!["data"]!["results"]
        return arrayjson
    }
}
