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
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func asLongerString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
