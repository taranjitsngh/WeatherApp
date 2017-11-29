//
//  ViewController.swift
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    // *********************************************************************************************
    // # MARK: - Constants
    
    let kUSerDefaultKey = "PreviousSearchedCity"
    
    // *********************************************************************************************
    // # MARK: - IBOutlet Properties

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempUnitSegmentCtrl: UISegmentedControl!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTitle: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    // *********************************************************************************************
    // # MARK: - Private Properties
    
    fileprivate var isCelcius = true
    
    fileprivate var primaryData: WeatherDataModel? {
        
        didSet {
            
            guard let primaryData = primaryData else {
                
                return
            }
            
            /*
             Setting up the UI elements with related data
             */
            
            updateTemperature()
            self.humidity.text = "\(Int(primaryData.main!.humidity))%"
            self.pressure.text = "\(primaryData.main?.pressure ?? 0)"
            self.weatherTitle.text = primaryData.weather[0].main
            let city = "\(primaryData.name), \(primaryData.sys?.country ?? "")"
            self.weatherDescription.text = city
            self.windSpeed.text = String(format: "%.1f mph", primaryData.wind.speed)
            self.sunrise.text = UnitConvertUtil.getTimeStringFromDate((primaryData.sys?.sunrise)!)
            self.sunset.text = UnitConvertUtil.getTimeStringFromDate((primaryData.sys?.sunset)!)
            let weatherImage = URL(string: primaryData.weather[0].iconImgUrl!)
            DispatchQueue.global(qos: .userInitiated).async {
                guard let imageData = try? Data(contentsOf: weatherImage!) else {
                    return
                }
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.weatherIcon.image = image
                    }
                }
            }
        }
    }
    
    fileprivate var suggestedCities = [[String: AnyObject]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // *********************************************************************************************
    // # MARK: - View Controller Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Getting the previously searched city and get its weather data
         */
        
        self.dateLbl.text = UnitConvertUtil.getDateStringFromDate(Date())
        let cityID = UserDefaults.standard.integer(forKey: self.kUSerDefaultKey)
        if cityID > 0 {
            getTodaysWeatherForCityID(cityId: cityID)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // *********************************************************************************************
    // # MARK: - UITextfield Delegate method
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        /*
         Populating suggestions for user
         */
        
        if let text = textField.text as NSString? {
            let city = text.replacingCharacters(in: range, with: string)
            self.suggestedCities = WeatherDataManager.shared.getCityListForName(city: city)
            self.tableView.isHidden = city.count == 0
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.tableView.isHidden = true
        
        return true
    }
    
    // *********************************************************************************************
    // # MARK: - UITableView DataSource and Delegate methods
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = suggestedCities.count == 0
        
        return suggestedCities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        let data = suggestedCities[indexPath.row]
        if let name = data["name"] as? String,
           let country = data["country"] as? String {
                cell.textLabel?.text = "\(name), \(country)"
        } else {
                cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = suggestedCities[indexPath.row]
        if let id = data["id"] as? Int,
            let name = data["name"] as? String,
            let country = data["country"] as? String {
            let city = "\(name), \(country)"
            searchTextField.text = city
            searchTextField.resignFirstResponder()
            tableView.isHidden = true
            getTodaysWeatherForCityID(cityId: id)
        }
    }
   
    
    @IBAction func temperatureUnitChanged(_ sender: UISegmentedControl) {
        isCelcius = sender.selectedSegmentIndex == 0
        updateTemperature()
    }
    
    
    // *********************************************************************************************
    // # MARK: - Private methods
    
    fileprivate func getTodaysWeatherForCityID(cityId: Int) {
        
        /*
         The Data manager will fetch the city waether report from the server and convert it into models
         */
        WeatherDataManager.shared.getWeatherDataForCity(cityId) { (data, error) in
            if error != nil {
                print("Failed" + error.debugDescription)
                return
            }
            if let primaryData = data?.first {
                self.primaryData = primaryData
                UserDefaults.standard.set(cityId, forKey: self.kUSerDefaultKey)
            }
        }
    }

    
    fileprivate func updateTemperature() {
        guard let primaryData = primaryData else {
            
            return
        }
        if isCelcius {
            let highTemp = UnitConvertUtil.getCelsiusFromKelvin(primaryData.main!.temp_max)
            self.highTemp.text = "\(Int(highTemp))˚"
            
            let lowTemp = UnitConvertUtil.getCelsiusFromKelvin(primaryData.main!.temp_min)
            self.lowTemp.text = "\(Int(lowTemp))˚"
            
            let temp = UnitConvertUtil.getCelsiusFromKelvin(primaryData.main!.temp)
            self.temperature.text = "\(Int(temp))˚"
        } else {
            let highTemp = UnitConvertUtil.getFahrenheitFromKelvin(primaryData.main!.temp_max)
            self.highTemp.text = "\(Int(highTemp))˚"
            
            let lowTemp = UnitConvertUtil.getFahrenheitFromKelvin(primaryData.main!.temp_min)
            self.lowTemp.text = "\(Int(lowTemp))˚"
            
            let temp = UnitConvertUtil.getFahrenheitFromKelvin(primaryData.main!.temp)
            self.temperature.text = "\(Int(temp))˚"
        }
    }
    
}

