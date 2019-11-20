//
//  ConvertorHelper.swift
//  WeatherForecast
//
//  Created by Ana on 20/11/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

enum ConvertorHelper {
  
  static func convertFahrenheitToCelsius(tempInFahrenheit: Double) -> Int {
    let celsius = (tempInFahrenheit - 32) * (5/9)
    return Int(celsius)
  }
}
