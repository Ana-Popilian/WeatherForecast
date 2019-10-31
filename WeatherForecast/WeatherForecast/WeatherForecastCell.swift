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
    self.backgroundColor = .green
    setupLayoutForCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindData(_ hourForecast: HourForcast) {
    dateLabel.text = hourForecast.formattedDate
    temperatureLabel.text = "\(hourForecast.details.temperature) ℃"
  }
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .green
    return label
  }()
  
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .green
    return label
  }()
  
  private func setupLayoutForCell() {
    
    addSubview(dateLabel)
    addSubview(temperatureLabel)
    
    NSLayoutConstraint.activate([
      
      dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
     // dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
      temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      //temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

