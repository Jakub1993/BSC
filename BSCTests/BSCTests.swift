//
//  BSCTests.swift
//  BSCTests
//
//  Created by Jakub Louda on 27.07.18.
//  Copyright © 2018 BSC Louda. All rights reserved.
//

import XCTest
@testable import BSC

class BSCTests: XCTestCase {
    
    var vc = NotesController()
    
    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testgetSymbols() {
        XCTAssertTrue(vc.getSymbols(languageNames: vc.languageNames).contains("en"), "Musí zde být ANGLIČTINA!")
    }
}
