//
//  URL+Async.swift
//  marvelproj
//
//  Created by André Nogueira on 9/26/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: self) {
            print("Task completed")
            completion($0, $1, $2)
            }.resume()
    }
}
