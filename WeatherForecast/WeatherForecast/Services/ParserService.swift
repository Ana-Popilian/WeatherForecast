//
//  Parser.swift
//  WeatherForecast
//
//  Created by Ana on 20/11/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

final class ParserService {
func fetchImage(imageName: String, completion: @escaping (Data?) -> ()) {
  
  let baseURl = "http://openweathermap.org/img/wn/\(imageName)@2x.png"
  let url = URL(string: baseURl)!
  
  let request = URLRequest(url: url)
  let sessionConfig = URLSessionConfiguration.default
  sessionConfig.timeoutIntervalForResource = 8
  
  let session = URLSession(configuration: sessionConfig)
  
  let task = session.dataTask(with: request, completionHandler: { data, response, error in
    completion(data)
  })
  task.resume()
}
}
//final class ParserService {
//  
//  func parsedCities() -> [CityModel] {
//    do {
//      if let file = Bundle.main.url(forResource: "cityList", withExtension: "json") {
//        let data = try Data(contentsOf: file)
//        
//        let decoder = JSONDecoder()
//        let jsonResult = try decoder.decode([CityModel].self, from: data)
//        
//        return jsonResult
//      }
//    } catch {
//      print(error.localizedDescription)
//    }
//    
//    return [CityModel]()
//  }
//}
