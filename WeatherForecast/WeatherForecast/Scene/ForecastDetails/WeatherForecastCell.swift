//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class WeatherForecastForFiveDaysCell: UICollectionViewCell, Identifiable {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = ColorHelper.customGreen
    
    addSubviews()
    setupConstraints()
  }
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 10
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateUI(by hourForecast: HourForcast) {
    
    let temp = hourForecast.details.temperature
//    let celsiusTemperature = ConvertorHelper.convertFahrenheitToCelsius(tempInFahrenheit: temp)
    temperatureLabel.text = String(temp)
//    "\(celsiusTemperature)℃"
    
    dateLabel.text = hourForecast.formattedDate
  }
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 13)
    label.textAlignment = .center
    return label
  }()
  
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    return label
  }()
}


//MARK: - Constraints Zone
private extension WeatherForecastForFiveDaysCell {
  
  func addSubviews() {
    addSubviewWC(dateLabel)
    addSubviewWC(temperatureLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
