//
//  City.swift
//  WeatherForecast
//
//  Created by Ana on 8/10/2020.
//  Copyright © 2010 Ana. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
  let weatherList: [List]
  let city: City
  
  private enum CodingKeys: String, CodingKey {
    case city
    case weatherList = "list"
  }
}

struct City: Decodable {
  let name: String
}

struct List: Decodable {
  let date: Date
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
