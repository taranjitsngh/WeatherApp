//
//  WeatherDataModelTest.swift
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class WeatherDataModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
      
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmptyJson() {
        let newModel = WeatherDataModel.init(json: [:])
        XCTAssertNil(newModel)
    }
    
    func testInvalidJson() {
        let testJson = "{\"coord\":{\"lon\":-119.75,\"lat\":37.25},\"base\":\"stations\",\"main\":{\"temp\":291.84,\"pressure\":1022,\"humidity\":49,\"temp_min\":289.15,\"temp_max\":293.15},\"visibility\":4828,\"wind\":{\"speed\":1.72,\"deg\":207.51},\"clouds\":{\"all\":1},\"dt\":1511296500,\"sys\":{\"type\":1,\"id\":389,\"message\":0.165,\"country\":\"US\",\"sunrise\":1511275536,\"sunset\":1511311472},\"id\":5332921,\"name\":\"California\",\"cod\":200}"
       
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = WeatherDataModel.init(json: testData)
        XCTAssertNil(newModel)
    }
    
    func testValidJson() {
        let testJson = "{\"coord\":{\"lon\":-119.75,\"lat\":37.25},\"weather\":[{\"id\":721,\"main\":\"Haze\",\"description\":\"haze\",\"icon\":\"50d\"}],\"base\":\"stations\",\"main\":{\"temp\":291.84,\"pressure\":1022,\"humidity\":49,\"temp_min\":289.15,\"temp_max\":293.15},\"visibility\":4828,\"wind\":{\"speed\":1.72,\"deg\":207.51},\"clouds\":{\"all\":1},\"dt\":1511296500,\"sys\":{\"type\":1,\"id\":389,\"message\":0.165,\"country\":\"US\",\"sunrise\":1511275536,\"sunset\":1511311472},\"id\":5332921,\"name\":\"California\",\"cod\":200}"
        
        var testData = [String: AnyObject]()
        if let data = testJson.data(using: .utf8) {
            do {
                testData = (try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject])!
            } catch {
                print(error.localizedDescription)
            }
        }
        let newModel = WeatherDataModel.init(json: testData)
        XCTAssertEqual(newModel?.name, "California")
        // Can check all values here
    }
    
}
