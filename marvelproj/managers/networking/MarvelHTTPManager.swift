//
//  MarvelHTTPManager.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import Keys
import RxAlamofire
import RxSwift
import SwiftyJSON
import Alamofire

class MarvelHTTPManager: NSObject {
    
    internal struct MarvelAPIService {
        fileprivate static let keys = MarvelprojKeys()
        static let apikey = keys.marvelprojAPIClientPrivate
        static let publicKey = keys.marvelprojAPIClientPublic
    }
}

