//
//  TemperatureMainModelTest.swift
//  WeatherAppTests
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class TemperatureMainModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyJson() {
        let newModel = TemperatureMainModel(json: [:])
        XCTAssertNil(newModel)
    }
    
    func testInvalidJson() {
        let testJson = "{\"pressure\": 1022,\"humidity\": 49,\"temp_min\": 289.15,\"temp_max\": 293.15}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = TemperatureMainModel(json: testData)
        XCTAssertNil(newModel)
    }
    
    func testValidJson() {
        let testJson = "{\"temp\": 291.84,\"pressure\": 1022,\"humidity\": 49,\"temp_min\": 289.15,\"temp_max\": 293.15}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = TemperatureMainModel(json: testData)
        XCTAssertEqual(newModel?.pressure, 1022)
        // Can check all values here
    }
    
}
