//
//  SeriesEntityTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest

@testable import marvelproj

class SeriesEntityTest: XCTestCase {
    var bundle: Bundle?
    var mockHelper: MockHelper?
    
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)) as? Bundle else{
            return XCTFail("Couldn't load bundle for this test class")
        }
        
        self.bundle = bundle
        self.mockHelper = MockHelper(file: "series", in: bundle)
   
    }

    func testSeries() {
        
        guard let json = mockHelper?.json else{
            return XCTFail("JSON did not load")
        }
        
        guard let dict = mockHelper?.convertStringToDict(json: json) else{
            return XCTFail("Couldnt convert this json string to dictionary")
        }
        
        guard let result = mockHelper?.removeWrappers(jsonWithObjectRoot: dict) else{
            return XCTFail("Couldnt remove wrappers from the dictionary")
        }
        
        var series:[marvelproj.Series] = []
        
        for item in result{
            guard let serie = marvelproj.Series(json: item) else{
                return XCTFail("Couldnt create model of \(item)")
            }
            
            series.append(serie)
        }
        
        XCTAssertFalse(series.isEmpty)
        XCTAssertEqual(series.count, 3)
        
        let serie = series[0]
        
        XCTAssertEqual(serie.title, "Uncanny X-Men (1963 - 2011)")
        XCTAssertEqual(serie.id, 2258)
        
    }
}
