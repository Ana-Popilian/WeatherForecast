//
//  WeatherForecastForFiveDays.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

struct ForecastResult {
  var dayTime: String
  var temperature: Main
  var wind: Wind
}

struct Main {
  var temperature: Int
  var pressure: Int
  var humidity: Int
}

struct Wind {
  var speed: Int
}
