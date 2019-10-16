//
//  City.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

struct City: Codable {
  var name: String
  var country: String
  var id: Int
  var coord: Coord
}

struct Coord: Codable {
  let lon: Double
  let lat: Double
}
