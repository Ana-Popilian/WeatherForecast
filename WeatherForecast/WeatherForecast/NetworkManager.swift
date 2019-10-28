//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Ana on 28/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class NetworkManager {
  
  func getWeatherData(completionHandler: @escaping (_ forecastResult: ForecastResult?) -> Void) {
    
    guard let url = URL(string: "https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b6907d289e10d714a6e88b30761fae22") else { return }
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data else { return }
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ForecastResult.self, from: data)
        
        completionHandler(response)
        
      } catch let error {
        completionHandler(nil)
        print(error.localizedDescription)
      }
    }
    request.resume()
  }
}
