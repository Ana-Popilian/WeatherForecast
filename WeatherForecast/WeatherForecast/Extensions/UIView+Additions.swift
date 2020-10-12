//
//  UIView+Additions.swift
//  WeatherForecast
//
//  Created by Ana on 20/11/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

extension UIView {
  
  func addSubviewWC(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
  }
}

