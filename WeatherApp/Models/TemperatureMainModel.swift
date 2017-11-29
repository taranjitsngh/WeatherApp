//
//  TemperatureMainModel.swift
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//


// *************************************************************************************************
// # MARK: - Imports

import UIKit

// *************************************************************************************************
// # MARK: - Class Defination

class TemperatureMainModel: NSObject {
    
    // *********************************************************************************************
    // # MARK: - Properties
    
        var temp: Double
        var pressure: Int
        var humidity: Int
        var temp_min: Double
        var temp_max: Double
    
    // *********************************************************************************************
    // # MARK: - Initialization
    
    fileprivate override init() {
        temp = 0.0
        pressure = 0
        humidity = 0
        temp_min = 0.0
        temp_max = 0.0
        
        super.init()
    }
    
    /*
     Creating Model from json dictionary
     */
    public required init?(json jsonDictionary: Dictionary<String, AnyObject>) {
        guard let temp = jsonDictionary["temp"] as? Double,
            let pressure = jsonDictionary["pressure"] as? Int,
            let humidity = jsonDictionary["humidity"] as? Int,
            let temp_min = jsonDictionary["temp_min"] as? Double,
            let temp_max = jsonDictionary["temp_max"] as? Double else {
                
                return nil
        }
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
        
        super.init()
    }
}
