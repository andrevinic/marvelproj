//
//  MarvelHTTPManager+Events.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension MarvelHTTPManager{
    
    func fetchEvents(characterID: Int, completion: @escaping (_ events: [Events], _ error: Error?) -> Void){
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + dict.privateKey + dict.publicKey).md5
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: dict.publicKey, hash: hash, characterID: characterID, detailExtension: "events")
        let session = URLSession.shared
        
        guard let requestUrl = URL(string:url) else { return }
        let request = URLRequest(url:requestUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                //JSONSerialization
                
                if let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]{
                    
                    let events = self.parseToEvents(jsonWithObjectRoot: jsonWithObjectRoot)
                    completion(events, error)
                }
                
            }
        }
        
        task.resume()
    }
}
