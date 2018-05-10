//
//  MarvelHTTPManager+Series.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

extension MarvelHTTPManager{

    func fetchSeries(characterID: Int, completion: @escaping (_ series: [Series], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + dict.privateKey + dict.publicKey).md5
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: dict.publicKey, hash: hash, characterID: characterID, detailExtension: "series")
        let session = URLSession.shared
        
        guard let requestUrl = URL(string:url) else { return }
        let request = URLRequest(url:requestUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                //JSONSerialization
                
                if let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]{
                    
                    let series = self.parseToSeries(jsonWithObjectRoot: jsonWithObjectRoot)
                    completion(series, error)
                }
                
            }
        }
        
        task.resume()
    }
}
