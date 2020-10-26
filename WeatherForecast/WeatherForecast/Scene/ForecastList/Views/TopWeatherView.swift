//
//  TopWeatherView.swift
//  WeatherForecast
//
//  Created by Ana on 26/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

final class TopWeatherView: UIView {
  
  var cityNameLabel: UILabel!
  var containerView: UIView!
  var temperatureLabel: UILabel!
  var descriptionImageView: UIImageView!
  var descriptionLabel: UILabel!
  var humidityImageView: UIImageView!
  var humidityLabel: UILabel!
  var windImageView: UIImageView!
  var windLabel: UILabel!
  var pressureImageView: UIImageView!
  var pressureLabel: UILabel!
  
  required init() {
    super.init(frame: .zero)
    
    setupUI()
    
    addSubViews()
    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


// MARK: - Private Zone
private extension TopWeatherView {
  
  func setupUI() {
    setupCityName()
    setupContainer()
    setupTemperatureLabel()
    setupDescriptionImageView()
    setupDescriptionLabel()
    setupHumidityImageView()
    setupHumidityLabel()
    setupWindImageView()
    setupWindLabel()
    setupPressureImageView()
    setupPressureLabel()
    
  }
  
  func setupCityName() {
    let font = UIFont.systemFont(ofSize: 20)
    cityNameLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupContainer() {
    containerView = UIView()
  }
  
  func setupTemperatureLabel() {
    let font = UIFont.systemFont(ofSize: 20)
    temperatureLabel = UILabel(font: font, textAlignment: .left, textColor: .black)
  }
  
  func setupDescriptionImageView() {
    descriptionImageView = UIImageView()
  }
  
  func setupDescriptionLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    descriptionLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupHumidityImageView() {
    let image = UIImage(named: "img_humidity")!
    humidityImageView = UIImageView(image: image)
  }
  
  func setupHumidityLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    humidityLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupWindImageView() {
    let image = UIImage(named: "img_wind")!
    windImageView = UIImageView(image: image)
  }
  
  func setupWindLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    windLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupPressureImageView() {
    let image = UIImage(named: "img_pressure")!
    pressureImageView = UIImageView(image: image)
  }
  
  func setupPressureLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    pressureLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
  }
}

// MARK: - Constraints Zone
private extension TopWeatherView {
  
  func addSubViews() {
    addSubviewWC(cityNameLabel)
    addSubviewWC(containerView)
    containerView.addSubviewWC(temperatureLabel)
    containerView.addSubviewWC(descriptionImageView)
    containerView.addSubviewWC(descriptionLabel)
    containerView.addSubviewWC(humidityImageView)
    containerView.addSubviewWC(humidityLabel)
    containerView.addSubviewWC(windImageView)
    containerView.addSubviewWC(windLabel)
    containerView.addSubviewWC(pressureImageView)
    containerView.addSubviewWC(pressureLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      cityNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      
      containerView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      temperatureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
      temperatureLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      
      descriptionImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      descriptionImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      descriptionImageView.heightAnchor.constraint(equalToConstant: 40),
      descriptionImageView.widthAnchor.constraint(equalToConstant: 40),
      
      descriptionLabel.leadingAnchor.constraint(equalTo: descriptionImageView.trailingAnchor, constant: 10),
      descriptionLabel.centerYAnchor.constraint(equalTo: descriptionImageView.centerYAnchor),
      
      humidityImageView.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 5),
      humidityImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      humidityImageView.heightAnchor.constraint(equalToConstant: 25),
      humidityImageView.widthAnchor.constraint(equalToConstant: 25),
      
      humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 20),
      humidityLabel.centerYAnchor.constraint(equalTo: humidityImageView.centerYAnchor),
      
      windImageView.topAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 5),
      windImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      windImageView.heightAnchor.constraint(equalToConstant: 30),
      windImageView.widthAnchor.constraint(equalToConstant: 30),
      
      windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 20),
      windLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
      
      pressureImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 10),
      pressureImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      pressureImageView.heightAnchor.constraint(equalToConstant: 25),
      pressureImageView.widthAnchor.constraint(equalToConstant: 25),
      
      pressureLabel.leadingAnchor.constraint(equalTo: pressureImageView.trailingAnchor, constant: 20),
      pressureLabel.centerYAnchor.constraint(equalTo: pressureImageView.centerYAnchor),
      pressureLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
}
