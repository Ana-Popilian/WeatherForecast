//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class WeatherForecastForFiveDaysCell: UICollectionViewCell, Identifiable {
  
  private var hourLabel: UILabel!
  private var temperatureLabel: UILabel!
  private var forecastImage: UIImageView!
  
  private enum ViewTrait {
    static let cornerRadius: CGFloat = 15
    static let defaultVerticalSpacing: CGFloat = 10
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = ColorHelper.customGreen
    layer.cornerRadius = ViewTrait.cornerRadius
    setupUI()
    
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateUI(by hourForecast: Detail) {
    
    hourLabel.text = hourForecast.date.asString(style: .long)
    temperatureLabel.text = String(hourForecast.tempInfo.temp)
    
    guard let image = hourForecast.weather.first?.icon else {
      return
    }
    forecastImage.downloadImage(name: image, downloadFinishedHandler: {
    })
  }
}


// MARK: - Private Zone
private extension WeatherForecastForFiveDaysCell {
  
  func setupUI() {
    setupHourLabel()
    sestupForecastImage()
    setupTemperatureLabel()
    
    addSubviews()
    setupConstraints()
  }
  
  func setupHourLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    hourLabel = UILabel(text: "10:00", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func sestupForecastImage() {
    let image = UIImage(named: "img_wind")!
    forecastImage = UIImageView(image: image)
  }
  
  func setupTemperatureLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    temperatureLabel = UILabel(text: "13℃", font: font, textAlignment: .natural, textColor: .black)
  }
}


//MARK: - Constraints Zone
private extension WeatherForecastForFiveDaysCell {
  
  func addSubviews() {
    addSubviewWC(hourLabel)
    addSubviewWC(forecastImage)
    addSubviewWC(temperatureLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      
      hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      forecastImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      forecastImage.centerXAnchor.constraint(equalTo: hourLabel.centerXAnchor),
      forecastImage.widthAnchor.constraint(equalToConstant: 20),
      forecastImage.heightAnchor.constraint(equalToConstant: 20),

      temperatureLabel.topAnchor.constraint(equalTo: forecastImage.bottomAnchor, constant: 5),
      temperatureLabel.centerXAnchor.constraint(equalTo: hourLabel.centerXAnchor),
      temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    ])
  }
}
