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
    //
    //        RxAlamofire.requestJSON(.get, requestUrl)
    //            .debug()
    //            .subscribe(onNext: { [weak self] (r, json) in
    //                    print(json)
    //                }, onError: { [weak self] (error) in
    //                    print(error)
    //            })
    //            .disposed(by: disposeBag)
    
    //        let json = requestUrl.asyncDownload { (data, response, error) in
    //            guard
    //                let data = data,
    //                let dic =  (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
    //                let results = dic["data"] as? [[String: Any]]
    //                else{
    //                    print("error:", error ?? "nil")
    //                    return
    //            }
    //            DispatchQueue.main.async {
    //                print(results)
    //                //        self.tableData = results
    //                //        self.Indextableview.reloadData()
    //            }
    //        }
    //        let task = session.dataTask(with: request) {
    //            (data, response, error) in
    //            if error == nil {
    //                let decoder = JSONDecoder()
    //
    //                //JSONSerialization
    //                let gitData = try decoder.decode(Character.self, from: data)
    
    //                if let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]{
    //
    //
    //                    let characters = self.parseToCharacters(jsonWithObjectRoot: jsonWithObjectRoot)
    //                    completion(characters, error)
    //                }
    
    //            }
    //        }
    
    //        task.resume()
    
}



