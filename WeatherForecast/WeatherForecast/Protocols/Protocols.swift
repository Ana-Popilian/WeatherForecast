//
//  Protocols.swift
//  WeatherForecast
//
//  Created by Ana on 08/11/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import Foundation


protocol Identifiable {
  
  static var identifier: String { get }
}

extension Identifiable {
  
  static var identifier: String {
    return String(describing: self)
  }
}
