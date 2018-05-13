//
//  eventsEntityTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest

@testable import marvelproj

class EventsEntityTest: XCTestCase {
    var bundle: Bundle?
    var mockHelper: MockHelper?
    
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)) as? Bundle else{
            return XCTFail("Couldn't load bundle for this test class")
        }
        
        self.bundle = bundle
        self.mockHelper = MockHelper(file: "events", in: bundle)
        
    }
    
    func testevents() {
        
        guard let json = mockHelper?.json else{
            return XCTFail("JSON did not load")
        }
        
        guard let dict = mockHelper?.convertStringToDict(json: json) else{
            return XCTFail("Couldnt convert this json string to dictionary")
        }
        
        guard let result = mockHelper?.removeWrappers(jsonWithObjectRoot: dict) else{
            return XCTFail("Couldnt remove wrappers from the dictionary")
        }
        
        var events:[marvelproj.Events] = []
        
        for item in result{
            guard let serie = marvelproj.Events(json: item) else{
                return XCTFail("Couldnt create model of \(item)")
            }
            
            events.append(serie)
        }
        
        XCTAssertFalse(events.isEmpty)
        XCTAssertEqual(events.count, 1)
        
        let serie = events[0]
        
        XCTAssertEqual(serie.title, "Age of Apocalypse")
        XCTAssertEqual(serie.id, 227)
        
    }
}

