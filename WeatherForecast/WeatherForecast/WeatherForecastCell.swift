//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit


class WeatherForecastForFiveDaysCell: UICollectionViewCell, Identifiable {
  
  let forecastView = WeatherForecastView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = ColorHelper.customGreen
    setupLayoutForCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bindData(_ hourForecast: HourForcast) {
    
    let temp = Int(hourForecast.details.temperature)
    let celsiusTemperature = forecastView.convertFahrenheitToCelsius(tempInFahrenheit: Double(temp))
    temperatureLabel.text = "\(celsiusTemperature)℃"
    
    dateLabel.text = hourForecast.formattedDate
  }
    
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private func setupLayoutForCell() {
    
    addSubview(dateLabel)
    addSubview(temperatureLabel)
    
    NSLayoutConstraint.activate([
      dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
      temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
