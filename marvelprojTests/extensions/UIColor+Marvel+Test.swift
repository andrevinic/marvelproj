//
//  UIColor+Marvel+Test.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest
@testable import marvelproj

class UIColor_Marvel_Test: XCTestCase {
    
    func testMarvelColor() {
        let marvelcolor = UIColor.marvel
        let rgb = UIColor(red: 25 / 255.0, green: 20 / 255.0, blue: 20 / 255.0, alpha: 1)
        XCTAssertTrue(marvelcolor.isEqual(rgb))
    }
    
}
