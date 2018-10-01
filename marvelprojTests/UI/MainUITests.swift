//
//  MainUITests.swift
//  marvelprojTests
//
//  Created by André Nogueira on 9/30/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import Quick
import KIF_Quick

class MainViewSpec: KIFSpec {
    
    override func spec() {
        describe("example app") {
            context("main view") {
                context("tap") {
                    it("should change to Thank you") {
                        let indexPath = IndexPath(row: 1, section: 0)
                        viewTester().tapRowInTableView(at: indexPath)
                    }
                }
            }
        }
    }
}
