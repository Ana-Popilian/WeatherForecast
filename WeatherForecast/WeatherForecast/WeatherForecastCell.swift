//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit


class WeatherForecastForFiveDaysCell: UICollectionViewCell, Identifiable {
  
//  var data: WeatherForecastForFiveDaysCell? {
//    didSet {
//      guard let data = data else {return}
//      dateLabel.text = data.dateLabel
//    }
//  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayoutForCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "25.10.2019"
    label.backgroundColor = .green
    return label
  }()
  
  let corespondentTemperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.text = "19℃"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .green
    return label
  }()
  
  func setupLayoutForCell() {
    
    addSubview(dateLabel)
    addSubview(corespondentTemperatureLabel)
    
    NSLayoutConstraint.activate([
      
      dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
      dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      corespondentTemperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
      corespondentTemperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      corespondentTemperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      corespondentTemperatureLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

