//
//  MockHelper.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

@testable import marvelproj

struct MockHelper{
    let data: Data
    let json: String
    
    init?(file: String, withExtension fileExt: String = "json", in bundle:Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: file, ofType: fileExt) else {
            return nil
        }
        let pathURL = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: pathURL, options: .dataReadingMapped)
            if let decoded = NSString(data: data, encoding: 0) as? String {
                json = decoded
            } else {
                return nil
            }
        } catch{
            return nil
        }
    }
}

extension MockHelper{
    func removeWrappers(jsonWithObjectRoot: [String:Any])->[[String:Any]]{
        if let datadictionary = try? jsonWithObjectRoot["data"] as! [String: Any]{
            let results = datadictionary["results"] as? [[String: Any]]
            return results!
        }
        return [jsonWithObjectRoot]
        
    }
    
    
    func convertStringToDict(json:String)->[String:Any]?{
        
        if let data = json.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}
