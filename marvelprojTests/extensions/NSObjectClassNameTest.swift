//
//  NSObjectClassNameTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest
@testable import marvelproj

class NSObjectClassNameTest: XCTestCase {
    
    func testClassName() {
       let marvelHTTManager = MarvelHTTPManager()
        XCTAssertEqual(marvelHTTManager.className, "MarvelHTTPManager")
        
        let queryBuilder = QueryBuilder.shared
        XCTAssertEqual(queryBuilder.className, "QueryBuilder")
        
    }
    
}
