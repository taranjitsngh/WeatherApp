//
//  UnitConvertUtil.swift
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import UIKit

class UnitConvertUtil: NSObject {

    static func getCelsiusFromKelvin(_ temp: Double) -> Double {
        
        return temp - 273.15
    }
    
    static func getFahrenheitFromKelvin(_ temp: Double) -> Double {
        
        return temp * (9/5) - 459.67
    }
    
    static func getTimeStringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM"
        let dateStr = formatter.string(from: date)
        
        return dateStr
    }
    
    static func getDateStringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let dateStr = formatter.string(from: date)
        
        return dateStr
    }
    
}
