//
//  WeatherModel.swift
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

class WeatherModel: NSObject {
    
    // *********************************************************************************************
    // # MARK: - Properties
    
    var descriptionString: String
    var id: Int
    var icon: String
    var iconImgUrl: String?
    var main: String

    // *********************************************************************************************
    // # MARK: - Initialization
    
    fileprivate override init() {
        id = 0
        main = ""
        descriptionString = ""
        icon = ""
        iconImgUrl = nil
        
        super.init()
    }
    
    /*
     Creating Model from json dictionary
     */
    public required init?(json jsonDictionary: Dictionary<String, AnyObject>) {
        guard let identifier = jsonDictionary["id"] as? Int,
              let mainStr = jsonDictionary["main"] as? String,
              let descStr = jsonDictionary["description"] as? String,
              let iconStr = jsonDictionary["icon"] as? String else {

                return nil
        }
        id = identifier
        main = mainStr
        descriptionString = descStr
        icon = iconStr
        iconImgUrl = "http://openweathermap.org/img/w/\(icon).png"
        super.init()
    }
}
