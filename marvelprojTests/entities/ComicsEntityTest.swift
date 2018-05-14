//
//  ComicsEntityTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest
@testable import marvelproj

class ComicsEntityTest: XCTestCase {
    var bundle: Bundle?
    var mockHelper: MockHelper?
    
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)) as? Bundle else{
            return XCTFail("Couldn't load bundle for this test class")
        }
        
        self.bundle = bundle
        self.mockHelper = MockHelper(file: "comics", in: bundle)
    }
    
    func testComics() {
        
        guard let json = mockHelper?.json else{
            return XCTFail("JSON did not load")
        }
        
        guard let dict = mockHelper?.convertStringToDict(json: json) else{
            return XCTFail("Couldnt convert this json string to dictionary")
        }
        
        guard let result = mockHelper?.removeWrappers(jsonWithObjectRoot: dict) else{
            return XCTFail("Couldnt remove wrappers from the dictionary")
        }
        
        var comics:[marvelproj.Comics] = []
        
        for item in result{
            guard let comic = marvelproj.Comics(json: item) else{
                return XCTFail("Couldnt create model of \(item)")
            }
            
            comics.append(comic)
        }
        
        XCTAssertFalse(comics.isEmpty)
        XCTAssertEqual(comics.count, 8)
        
        let comic = comics[0]
        
        XCTAssertEqual(comic.title, "X-Men: The Complete Age of Apocalypse Epic Book 2 (Trade Paperback)")
        XCTAssertEqual(comic.id, 2539)
        
    }
}
