//
//  WeatherForecastForFiveDays.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

struct ForecastModel: Decodable {
  let hourForcasts: [HourForcast]
  let city: City
  
  private enum CodingKeys: String, CodingKey {
    case hourForcasts = "list"
    case city
  }
  
  struct City: Decodable {
    var name: String
  }
}

struct HourForcast: Decodable {
  let formattedDate: String
  let details: Details
  let wind: Wind
  
  private enum CodingKeys: String, CodingKey {
    case formattedDate = "dt_txt"
    case details = "main"
    case wind
  }
  
  struct Details: Decodable {
    let temperature: Double
    let pressure: Double
    let humidity: Double
    
    private enum CodingKeys: String, CodingKey {
      case temperature = "temp"
      case pressure, humidity
    }
  }
  
  struct Wind: Codable {
    let speed: Double
  }
}
