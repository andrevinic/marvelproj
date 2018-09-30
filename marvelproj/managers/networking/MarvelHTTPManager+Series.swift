//
//  MarvelHTTPManager+Series.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension MarvelHTTPManager{

    func fetchSeries(characterID: Int, completion: @escaping (_ series: [Series]?, _ error: Error?) -> Void){
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + MarvelAPIService.apikey + MarvelAPIService.publicKey).md5
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: MarvelAPIService.publicKey, hash: hash, characterID: characterID, detailExtension: "series", limit: LIMIT_OF_FETCH_COLLECTION_VIEW_SERIES)
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
                        
                        let response =  try JSONDecoder().decode([Series].self, from: data)
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
