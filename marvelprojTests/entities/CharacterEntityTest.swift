//
//  CharacterTableViewCellTest.swift
//  marvelprojTests
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import XCTest
@testable import marvelproj

class CharacterEntityTest: XCTestCase {
    
    var bundle: Bundle?
    var mockHelper: MockHelper?
    
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)) as? Bundle else{
            return XCTFail("Couldn't load bundle for this test class")
        }
        
        self.bundle = bundle
        self.mockHelper = MockHelper(file: "characters_response", in: bundle)
    }
    
    func testCharacters() {
        
        //
        //        guard let view = bundle.loadNibNamed(CharacterTableViewCell.className, owner: nil, options: nil)?.first as? CharacterTableViewCell else{
        //            return XCTFail("CharacterTableViewCell nib did not contain a UIView")
        //        }
        
        guard let json = mockHelper?.json else{
            return XCTFail("JSON did not load")
        }
        
        guard let dict = mockHelper?.convertStringToDict(json: json) else{
            return XCTFail("Couldnt convert this json string to dictionary")
        }
        
        guard let result = mockHelper?.removeWrappers(jsonWithObjectRoot: dict) else{
            return XCTFail("Couldnt remove wrappers from the dictionary")
        }
        
        var characters: [marvelproj.Character] = []
        for item in result{
            
            guard let char = marvelproj.Character(json: item) else{
                return XCTFail("Couldnt convert \(item) to model character")
            }
            
            characters.append(char)
        }
        
        XCTAssertNotNil(characters)
        XCTAssertFalse(characters.isEmpty)
        XCTAssertEqual(characters.count, 2)
        
        let char = characters[0]
        XCTAssertEqual(char.id, 1011334)
        XCTAssertEqual(char.name, "3-D Man")
        XCTAssertEqual(char.description.count, 0)
       
        let thumbnail = char.thumbnail
        XCTAssertNotNil(thumbnail)
        XCTAssertEqual(thumbnail?.tExtension, "jpg")
        XCTAssertEqual(thumbnail?.path, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
        XCTAssertTrue((thumbnail?.securePath().contains("https"))!)
        
    }
    
    
}


