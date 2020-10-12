//
//  Parser.swift
//  WeatherForecast
//
//  Created by Ana on 20/11/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

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
