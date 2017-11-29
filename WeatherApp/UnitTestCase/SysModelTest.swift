//
//  SysModelTest.swift
//  WeatherAppTests
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class SysModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyJson() {
        let newModel = SysModel.init(json: [:])
        XCTAssertNil(newModel)
    }
    
    func testInvalidJson() {
        let testJson = "{\"type\": 1,\"id\": 389,\"message\": 0.165,\"country\": \"US\",\"sunset\": 1511311472}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = SysModel.init(json: testData)
        XCTAssertNil(newModel)
    }
    
    func testValidJson() {
        let testJson = "{\"type\": 1,\"id\": 389,\"message\": 0.165,\"country\": \"US\",\"sunrise\": 1511275536,\"sunset\": 1511311472}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = SysModel.init(json: testData)
        XCTAssertEqual(newModel?.country, "US")
        // Can check all values here
    }
    
    
}
