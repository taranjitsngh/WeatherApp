//
//  WeatherModelTest.swift
//  WeatherAppTests
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class WeatherModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyJson() {
        let newModel = WeatherModel.init(json: [:])
        XCTAssertNil(newModel)
    }
    
    func testInvalidJson() {
        let testJson = "{\"id\": 721,\"description\": \"haze\",\"icon\": \"50d\"}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = WeatherModel.init(json: testData)
        XCTAssertNil(newModel)
    }
    
    func testValidJson() {
        let testJson = "{\"id\": 721,\"main\": \"Haze\",\"description\": \"haze\",\"icon\": \"50d\"}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = WeatherModel.init(json: testData)
        XCTAssertEqual(newModel?.main, "Haze")
        // Can check all values here
    }
    
   
    
}
