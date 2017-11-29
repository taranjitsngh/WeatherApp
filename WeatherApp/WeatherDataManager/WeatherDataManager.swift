//
//  WeatherDataManager
//  WeatherApp
//
//  Created by Taranjit Lottey on 11/21/17.
//  Copyright © 2017 Mitra di company. All rights reserved.
//

import UIKit

class WeatherDataManager: NSObject {
    
    // *********************************************************************************************
    // MARK: Shared Instance
    
    @objc public static let shared = WeatherDataManager()
    
    // *********************************************************************************************
    // MARK:  Private Properties
    
    fileprivate let apiKey = "c6e6138ad682d326a1270b77ef134511"
    fileprivate let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate var cityList: [[String: AnyObject]]?
    fileprivate let processingQueue = OperationQueue()
    
    
    // *********************************************************************************************
    // MARK: Public Methods
    
    /*
     Fetch all US city list from local json; As the list is small I have stored it in cache
     We can also have a server setup so that it returns the suggested cities list
     */
    func setup() {
        cityList = loadLocalCityList()
    }
    
    
    func getWeatherDataForCity(_ cityID: Int,
                               completion: @escaping (_ results: [WeatherDataModel]?, _ error : NSError?) -> Void) {
        
        /*
         Checking the URL and all corner cases
         */
        
        guard let searchURL = weatherURL(cityID) else {
            let APIError = NSError(domain: "WeatherError",
                                   code: 0,
                                   userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                let APIError = NSError(domain: "WeatherError",
                                       code: 0,
                                       userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                OperationQueue.main.addOperation({
                    completion(nil, APIError)
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: "WeatherError",
                                           code: 0,
                                           userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                    OperationQueue.main.addOperation({
                        completion(nil, APIError)
                    })
                    return
            }
            
            do {
                guard let resultsDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                        
                        let APIError = NSError(domain: "WeatherError", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                        OperationQueue.main.addOperation({
                            completion(nil, APIError)
                        })
                        return
                }
                // Create Multiple Weather models if there are any
                
                if let list = resultsDictionary["list"] as? [String: AnyObject] {
                    /*
                     If there was enough time I would have properly implemented it
                     */
                    print(list)
                    return
                }
                
                // Create 1 weather Model
                self.processingQueue.addOperation {
                    let weatherData = WeatherDataModel.init(json: resultsDictionary)
                    if let weatherData = weatherData {
                        OperationQueue.main.addOperation({
                            completion([weatherData], nil)
                        })
                    } else {
                        let APIError = NSError(domain: "WeatherError", code: 0, userInfo:
                            [NSLocalizedFailureReasonErrorKey:"Unable to parse response"])
                        OperationQueue.main.addOperation({
                            completion(nil, APIError)
                        })
                    }
                }
                
                
            } catch _ {
                completion(nil, nil)
                return
            }
            
            
        }).resume()
    }
    
    /*
     Get suggested city names based to search
     */
    func getCityListForName(city: String) -> [[String: AnyObject]] {
        if cityList == nil {
            return []
        }
        let namePredicate =
            NSPredicate(format: "name contains[cd] %@", city);
        let newCityList = cityList!.filter { namePredicate.evaluate(with: $0) };
        
        return newCityList
    }
    
    
    // ****************************************************************************************
    // MARK:  Private Methods
    
    /*
     Load city list into cache
     */
    fileprivate func loadLocalCityList() -> [[String: AnyObject]]? {
        if let path = Bundle.main.path(forResource: "USCityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<Dictionary<String, AnyObject>> {
                    return jsonResult
                }
            } catch {
                print("Error: Unable to load to City list")
        
                return nil
            }
        }
        print("Error: Unable to load to City list")
        
        return nil
    }
    
    /*
     Generate URL
     */
    fileprivate func weatherURL(_ cityID: Int) -> URL? {
        let urlString = "\(baseURL)?id=\(cityID)&APPID=\(apiKey)"
        
        guard let url_ = URL(string: urlString) else {
            return nil
        }
        
        return url_
    }
}
