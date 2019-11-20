//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Ana on 28/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class NetworkManager {
  
  func getWeatherData(cityId: String, completionHandler: @escaping (_ forecastResult: ForecastModel) -> Void) {
    
    let apiKey = "&appid=9d4b20529a15bc127ff039cecd2d4793"
    let api = "http://api.openweathermap.org/data/2.5/forecast?id="
    let url = URL(string: api + cityId + apiKey)!
    
    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(ForecastModel.self, from: data!)
        
        completionHandler(response)
        
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch {
        print("error: ", error)
      }
    }
    request.resume()
  }
}
