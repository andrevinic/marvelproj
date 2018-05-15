//
//  MarvelHTTPManager+Characters.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension MarvelHTTPManager{
    
    func fetchCharacters(offset: Int, completion: @escaping (_ characters: [Character], _ error: Error?) -> Void){
        
        let dict: KeyDict = MarvelService.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + dict.privateKey + dict.publicKey).md5
        let offset = "\(offset)"
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: dict.publicKey, hash: hash, offset:offset, path: CHARACTER_EXT)
        let session = URLSession.shared
        
        guard let requestUrl = URL(string:url) else { return }
        let request = URLRequest(url:requestUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                //JSONSerialization
    
                if let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]{
                    
                    let characters = self.parseToCharacters(jsonWithObjectRoot: jsonWithObjectRoot)
                    completion(characters, error)
                }
                
            }
        }
        
        task.resume()
        
    }
}
