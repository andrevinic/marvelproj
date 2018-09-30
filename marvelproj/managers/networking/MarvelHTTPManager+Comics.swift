//
//  MarvelHTTPManager+Comics.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//
import Alamofire
import Foundation
import SwiftyJSON


extension MarvelHTTPManager{
    
    func fetchComics(characterID: Int, completion: @escaping (_ comics: [Comics]?, _ error: Error?) -> Void){
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + MarvelAPIService.apikey + MarvelAPIService.publicKey).md5
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: MarvelAPIService.publicKey, hash: hash, characterID: characterID, detailExtension: "comics", limit: LIMIT_OF_FETCH_COLLECTION_VIEW_COMICS)
        
        guard let requestUrl = URL(string:url) else { return }
        
        
        Alamofire.request(requestUrl).responseJSON { (response) in
            do {
                switch response.result{
                case .failure(_):
                    completion(nil, response.error)
                case .success(_):
                    if let json = response.result.value{
                        let swifty = try JSON(json)
                        let characters = swifty["data"]["results"].rawString()!
                        
                        let data = characters.data(using: .utf8)!
                        
                        let response =  try JSONDecoder().decode([Comics].self, from: data)
                        completion(response, nil)
                    }
                }
            }
        
            catch{
                print("Error creating the database")
                
            }
        }
        
    }
}
