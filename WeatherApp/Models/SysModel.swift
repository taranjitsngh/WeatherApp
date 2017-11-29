//
//  SysModel.swift
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *********************************************************************************************
// # MARK: - Imports

import UIKit

// *********************************************************************************************
// # MARK: - Class Defination

class SysModel: NSObject {
    
    // *********************************************************************************************
    // # MARK: - Properties
    
    var country: String
    var sunrise: Date
    var sunset: Date
    
    
    // *********************************************************************************************
    // # MARK: - Initialization
    
    fileprivate override init() {
        country = ""
        sunrise = Date()
        sunset = Date()
        
        super.init()
    }
    
    /*
     Creating Model from json dictionary
     */
    public required init?(json jsonDictionary: Dictionary<String, AnyObject>) {
        guard let country = jsonDictionary["country"] as? String,
            let sunrise = jsonDictionary["sunrise"] as? TimeInterval,
            let sunset = jsonDictionary["sunset"] as? TimeInterval else {
                
            return nil
        }
        
        self.country = country
        self.sunrise = Date(timeIntervalSince1970: sunrise)
        self.sunset = Date(timeIntervalSince1970: sunset)
        
        super.init()
    }
}
