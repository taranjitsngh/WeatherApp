//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

// *********************************************************************************************
// # MARK: - Imports

import UIKit


// *********************************************************************************************
// # MARK: - Structs Definations

struct windModel {
    var speed: Double
    var deg: Double
}


// *********************************************************************************************
// # MARK: - Class Definations

class WeatherDataModel: NSObject {
    
    // *********************************************************************************************
    // # MARK: - Properties
    
    var weather: [WeatherModel]
    var main: TemperatureMainModel?
    var wind: windModel
    var clouds: Int
    var sys: SysModel?
    var id: Int32
    var name: String
    
    // *********************************************************************************************
    // # MARK: - Initialization
    
    // No Default init
    fileprivate override init() {
        weather = []
        wind = windModel(speed: 0, deg: 0)
        clouds = 0
        id = 0
        name = ""
        
        super.init()
    }
    
    /*
     Creating Model from json dictionary
     */
    public required init?(json jsonDictionary: Dictionary<String, AnyObject>) {
        
        guard let wind = jsonDictionary["wind"] as? [String: Double],
            let main = jsonDictionary["main"] as? [String: AnyObject],
            let weather = jsonDictionary["weather"] as? [[String: AnyObject]],
            let sys = jsonDictionary["sys"] as? [String: AnyObject],
            let id = jsonDictionary["id"] as? Int32,
            let cloud = jsonDictionary["clouds"] as? [String: Int],
            let name = jsonDictionary["name"] as? String else {
            return nil
        }
        
        self.wind = windModel(speed: wind["speed"]!, deg: wind["deg"]!)
        self.main = TemperatureMainModel(json: main)
        var allWeather = [WeatherModel]()
        for eachWeather in weather {
            let newWeatherModel = WeatherModel(json: eachWeather)
            if let newWeatherModel =  newWeatherModel {
                allWeather.append(newWeatherModel)
            }
        }
        self.weather = allWeather
        
        clouds = cloud["all"] ?? 0
        self.id = id
        self.sys = SysModel.init(json: sys)
        self.name = name
        
        super.init()
    }
    
}
