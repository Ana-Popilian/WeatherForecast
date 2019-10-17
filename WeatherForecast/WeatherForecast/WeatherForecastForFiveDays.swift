//
//  WeatherForecastForFiveDays.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

struct ForecastResult: Codable {
  var dayTime: String
  var main: Main
  var wind: Wind
  
  private enum CodingKeys: String, CodingKey {
  case dayTime = "dt"
  case wind = "speed"
  case main 
  }
}

struct Main: Codable {
  var temperature: Int
  var pressure: Int
  var humidity: Int
  
  private enum CodingKeys: String, CodingKey {
    case temperature = "temp"
    case pressure
    case humidity
  }
}

struct Wind: Codable {
  var speed: Int
}
