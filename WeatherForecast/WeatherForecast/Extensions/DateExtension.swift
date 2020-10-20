//
//  DateExtension.swift
//  WeatherForecast
//
//  Created by Ana on 20/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import Foundation

extension Date {
  
  func asString(style: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
   dateFormatter.dateFormat = "dd MMM HH:mm"
    return dateFormatter.string(from: self)
  }
}
