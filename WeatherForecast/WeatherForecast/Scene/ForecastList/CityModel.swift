//
//  City.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation

struct CityModel: Codable {
  let name: String
  let country: String
  let id: Int
  let coord: CoordModel
}

struct CoordModel: Codable {
  let lon: Double
  let lat: Double
}
