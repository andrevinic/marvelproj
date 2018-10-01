//
//  MarvelHTTPManager+Characters.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON
import RxAlamofire
import RxSwift

extension MarvelHTTPManager{
    
    func fetchCharacters(offset: Int, completion: @escaping (_ characters: [Character]?, _ error: Error?) -> Void){// -> //Observable<Character>{

        let ts = NSDate().timeIntervalSince1970.description
        let hash = (ts + MarvelAPIService.apikey + MarvelAPIService.publicKey).md5
        let offset = "\(offset)"
        let queryBuilder = QueryBuilder.shared
        let url = queryBuilder.query(ts: ts, apikey: MarvelAPIService.publicKey, hash: hash, offset:offset, path: CHARACTER_EXT)
        
        if let requestUrl = URL(string:url){
            //            let request = URLRequest(url:requestUrl)
           
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

                            let response =  try JSONDecoder().decode([Character].self, from: data)
                            completion(response, nil)
                    }
                }
                }
                catch{
                    print("Error creating the database")

                }}
            
//            _ = json(.get, requestUrl)
//                .observeOn(MainScheduler.instance)
//                .subscribe {
//                    
//                    print($0) }
//            
//            _ = request(.get, requestUrl)
//                .flatMap { request in
//                    return request.validate(statusCode: 200..<300)
//                        .validate(contentType: ["text/json"])
//                        .rx.json()
//                }
//                .observeOn(MainScheduler.instance)
//                .subscribe { print($0) }

            
//            json(.get, requestUrl)
//                .observeOn(MainScheduler.instance)
//                .mapArray(type: [Character].self)
//                .subscribe(onNext: { characters in
//                    _ = characters.map { print($0) }
//                }).disposed(by: disposeBag)
//
//            //                .disposed(by: disposeBag)
//
//            let response = json(.get, requestUrl)
//                .observeOn(MainScheduler.instance)
//                .subscribe(onNext: { (json) in
//                    let swiftjson = JSON(json)
//                    let characters = swiftjson["data"]["results"].rawString()!
//                    let data = characters.data(using: .utf8)!
//                    //                    let decoder = try JSONDecoder().decode(Character.self, from: data)
//                    //                    let myChars = try JSONDecoder().decode([Character].self, from: data)
//
//                    //                    print(myChars)
//
//                }, onError: { (error) in
//
//                }, onCompleted: {
//
//                }, onDisposed: {
//
//                })
        }
        
//        return Observable.just(Character())
    }
 
    
}



