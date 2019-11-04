//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Ana on 28/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class NetworkManager {
  
  func getWeatherData(completionHandler: @escaping (_ forecastResult: ForecastResult) -> Void) {
    let cityId = ""
    let api = "api.openweathermap.org/data/2.5/forecast?id="
    let url = URL(string: api + cityId)
//    let url = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22")!
    
    let request = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ForecastResult.self, from: data!)
        
        completionHandler(response)
        
        print(response)
        
      } catch let error {
        fatalError("the error is \(error)")
      }
    }
    request.resume()
  }
}
