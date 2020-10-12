//
//  City.swift
//  ForecastWeather
//
//  Created by Ana on 8/10/2020.
//  Copyright © 2010 Ana. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
  let weatherList: [List]
  
  private enum CodingKeys: String, CodingKey {
    case weatherList = "list"
  }
}

struct List: Decodable {
  let date: Int
  let tempInfo: TempInfo
  let wind: Wind
  let weather: [Weather]
  
  private enum CodingKeys: String, CodingKey {
    case date = "dt"
    case tempInfo = "main"
    case wind, weather
  }
}

struct TempInfo: Decodable {
  let temp: Double
  let pressure: Int
  let humidity: Int
}

struct Wind: Decodable {
  let speed: Double
}

struct Weather: Decodable {
  let description: String
  let icon: String
}
