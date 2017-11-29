//
//  UnitConvertUtilTest.swift
//  WeatherAppTests
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import XCTest

class UnitConvertUtilTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCelcuisFromKelvin() {
        let result = UnitConvertUtil.getCelsiusFromKelvin(300)
        XCTAssertEqual(result, 26.850000000000023)
    }
    
    func testFahrenheitFromKelvin() {
        let result = UnitConvertUtil.getFahrenheitFromKelvin(300)
        XCTAssertEqual(result, 80.329999999999984)
    }
    
    func testGetTimeStringFromDate() {
        let timeStamp: TimeInterval = 1511275536
        let testDate = Date(timeIntervalSince1970: timeStamp)
        let result = UnitConvertUtil.getTimeStringFromDate(testDate)
        XCTAssertEqual(result, "06:11")
    }
    
    func testGetDateStringFromDate() {
        let timeStamp: TimeInterval = 1511275536
        let testDate = Date(timeIntervalSince1970: timeStamp)
        let result = UnitConvertUtil.getDateStringFromDate(testDate)
        XCTAssertEqual(result, "Nov 21")
        
    }
}
