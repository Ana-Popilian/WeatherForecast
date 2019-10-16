//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
     super.init(frame: frame)
     
   }
   
   required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }
  
  let dayOfTheWeek: UILabel = {
    let label = UILabel()
    return label
  }()
  
  let corespondentTemperature: UILabel = {
    let label = UILabel()
    return label
  }()
}

