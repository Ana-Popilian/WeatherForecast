//
//  CityCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell, Identifiable {
  
  private var hourLabel: UILabel!
  private var temperatureLabel: UILabel!
  private var weatherImage: UIImageView!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupUI()
  }
  
  private enum VT {
    static let defaultPadding: CGFloat = 30
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  private lazy var cityIdLabel: UILabel = getDefaultLabel()
//  private lazy var coordonatesLabel: UILabel = getDefaultLabel()
//  private lazy var cityNameLabel: UILabel = getDefaultLabel()
//  private lazy var countryNameLabel: UILabel = getDefaultLabel()
//
//  func updateUI(by city: CityModel) {
//
//    cityNameLabel.text = city.name
//    coordonatesLabel.text = getCoordinateFormatted(city)
//    cityIdLabel.text = String(city.id)
//    countryNameLabel.text = city.country
//  }
}


//MARK: - Private Zone
private extension CityCell {
  
  func setupUI() {
    setupHourLabel()
    setupTemperatureLabel()
    setupWeatherImage()
    
    addSubview()
    setupConstraints()
  }
  
  func setupHourLabel() {
    let font = UIFont.systemFont(ofSize: 13)
    hourLabel = UILabel(text: "12", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func setupTemperatureLabel() {
    let font = UIFont.systemFont(ofSize: 13)
    temperatureLabel = UILabel(text: "16℃", font: font, textAlignment: .natural, textColor: .black)
  }
  
  func setupWeatherImage() {
    let image = UIImage(named: "img_wind")!
    weatherImage = UIImageView(image: image)
  }
  
//  func getDefaultLabel() -> UILabel {
//    let label = UILabel()
//    label.font = UIFont.systemFont(ofSize: 13)
//    label.textAlignment = .center
//    return label
//  }
//
//  func getCoordinateFormatted(_ city: CityModel) -> String {
//    return "lat: \(city.coord.lat) lon: \(city.coord.lon)"
//  }
}


//MARK: - Constraints Zone
private extension CityCell {
  
  func addSubview() {
    addSubviewWC(hourLabel)
    addSubviewWC(temperatureLabel)
    addSubviewWC(weatherImage)
 
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      hourLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.defaultPadding),
      
      temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.defaultPadding),
      weatherImage.heightAnchor.constraint(equalToConstant: 25),
      weatherImage.widthAnchor.constraint(equalToConstant: 25),
    ])
  }
}
