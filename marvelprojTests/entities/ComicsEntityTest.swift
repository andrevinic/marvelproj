//
//  ComicsEntityTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest

class ComicsEntityTest: XCTestCase {
    var bundle: Bundle?
    var mockHelper: MockHelper?
    
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)) as? Bundle else{
            return XCTFail("Couldn't load bundle for this test class")
        }
        
        self.bundle = bundle
        self.mockHelper = MockHelper(file: "characters_response", in: bundle)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        guard let json = mockHelper?.json else{
            return XCTFail("JSON did not load")
        }
        
        guard let dict = mockHelper?.convertStringToDict(json: json) else{
            return XCTFail("Couldnt convert this json string to dictionary")
        }
        
        guard let result = mockHelper?.removeWrappers(jsonWithObjectRoot: dict) else{
            return XCTFail("Couldnt remove wrappers from the dictionary")
        }
        
        print(result)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
