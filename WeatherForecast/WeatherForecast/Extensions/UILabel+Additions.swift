//
//  UILabel+Additions.swift
//  WeatherForecast
//
//  Created by Ana on 05/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String? = nil, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
