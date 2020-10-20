//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class WeatherForecastForFiveDaysCell: UICollectionViewCell, Identifiable {
  
  private var dayLabel: UILabel!
  private var hourLabel: UILabel!
  private var temperatureLabel: UILabel!
  private var forcastImage: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = ColorHelper.customGreen
    
    setupUI()
    
  }
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 10
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //  func updateUI(by hourForecast: HourForcast) {
  //
  //    dateLabel.text = hourForecast.formattedDate
  //  }
  
}


// MARK: - Private Zone
private extension WeatherForecastForFiveDaysCell {
  
  func setupUI() {
    setupDayLabel()
    setupHourLabel()
    sestupForcastImage()
    setupTemperatureLabel()
    
    addSubviews()
    setupConstraints()
  }
  
  func setupDayLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    dayLabel = UILabel(text: "Tuesday", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func setupHourLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    hourLabel = UILabel(text: "10:00", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func sestupForcastImage() {
    let image = UIImage(named: "img_humidity")!
    forcastImage = UIImageView(image: image)
  }
  
  func setupTemperatureLabel() {
    let font = UIFont.systemFont(ofSize: 14)
     temperatureLabel = UILabel(text: "13℃", font: font, textAlignment: .natural, textColor: .black)
  }
}


//MARK: - Constraints Zone
private extension WeatherForecastForFiveDaysCell {
  
  func addSubviews() {
    addSubviewWC(dayLabel)
    addSubviewWC(hourLabel)
    addSubviewWC(forcastImage)
    addSubviewWC(temperatureLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      hourLabel.topAnchor.constraint(equalTo: topAnchor),
      hourLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
    ])
  }
}
