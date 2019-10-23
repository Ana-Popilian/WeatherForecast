//
//  WeatherForecastView.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

protocol WeatherViewDelegate where Self: UIViewController {
}

class WeatherForecastView: UIView {
  
  weak var delegate: WeatherViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let cityNameLabel: UILabel = {
    let name = UILabel()
    name.font = UIFont.systemFont(ofSize: 18)
    name.text = "City"
    name.textColor = .white
    name.textAlignment = .center
    name.translatesAutoresizingMaskIntoConstraints = false
    return name
  }()
  
  private let currentTemperatureLabel: UILabel = {
    let temperature = UILabel()
    temperature.font = UIFont.systemFont(ofSize: 16)
    temperature.text = "24℃"
    temperature.textColor = .white
    temperature.textAlignment = .center
    temperature.translatesAutoresizingMaskIntoConstraints = false
    return temperature
  }()
  
  private let humidityLabel: UILabel = {
    let humidity = UILabel()
    humidity.font = UIFont.systemFont(ofSize: 14)
    humidity.numberOfLines = 2
    humidity.text = "Humidity/n30"
    humidity.textColor = .white
    humidity.textAlignment = .center
    humidity.translatesAutoresizingMaskIntoConstraints = false
    return humidity
  }()
  
  private let pressureLabel: UILabel = {
    let pressure = UILabel()
    pressure.font = UIFont.systemFont(ofSize: 14)
    pressure.numberOfLines = 2
    pressure.text = "Pressure /n"
    pressure.textColor = .white
    pressure.textAlignment = .center
    pressure.translatesAutoresizingMaskIntoConstraints = false
    return pressure
  }()
  
  private let windlabel: UILabel = {
    let wind = UILabel()
    wind.font = UIFont.systemFont(ofSize: 14)
    wind.numberOfLines = 2
    wind.text = "Wind /n"
    wind.textColor = .white
    wind.textAlignment = .center
    wind.translatesAutoresizingMaskIntoConstraints = false
    return wind
  }()
  
  private let weatherForFiveDaysCollectionView: UICollectionViewFlowLayout = {
    let collectionView = UICollectionViewFlowLayout()
    collectionView.scrollDirection = .horizontal
    return collectionView
  }()
  
  private let humidityImageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "img_humidity.png"))
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let pressureImageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "img_pressure.png"))
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let windImageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "img_wind.png"))
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  func setupUI() {
    self.backgroundColor = UIColor(red: 11/255, green: 57/255, blue: 32/255, alpha: 1)
    
    
    addSubview(cityNameLabel)
    addSubview(currentTemperatureLabel)
    addSubview(humidityLabel)
    addSubview(pressureLabel)
    addSubview(windlabel)
    addSubview(humidityImageView)
    addSubview(pressureImageView)
    addSubview(windImageView)
    //    addSubview(weatherForFiveDaysCollectionView)
    
    NSLayoutConstraint.activate([
      cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
      cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      cityNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 60),
      currentTemperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      currentTemperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      humidityImageView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 30),
      humidityImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      humidityImageView.widthAnchor.constraint(equalToConstant: 50),
      humidityImageView.heightAnchor.constraint(equalToConstant: 40),
      
      pressureImageView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 30),
      pressureImageView.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 55),
      pressureImageView.widthAnchor.constraint(equalToConstant: 45),
      pressureImageView.heightAnchor.constraint(equalToConstant: 40),
      
      windImageView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 30),
      windImageView.leadingAnchor.constraint(equalTo: pressureImageView.trailingAnchor, constant: 60),
      windImageView.widthAnchor.constraint(equalToConstant: 40),
      windImageView.heightAnchor.constraint(equalToConstant: 40),
      
      
      humidityLabel.topAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 5),
      humidityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      //        humidityLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      pressureLabel.topAnchor.constraint(equalTo: pressureImageView.bottomAnchor, constant: 5),
      pressureLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 35),
      //        pressureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      windlabel.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 5),
      windlabel.leadingAnchor.constraint(equalTo: pressureLabel.trailingAnchor, constant: 5),
      windlabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
      
    ])
  }
  
  func bindView(forecastResult: ForecastResult) -> Void {
    let temp = Int(forecastResult.hourForcasts.first!.details.temperature)
    
    cityNameLabel.text = String(forecastResult.city.name)
    let celsiusTemperature = convertFahrenheitToCelsius(tempInFahrenheit: Double(temp))
    currentTemperatureLabel.text = "\(celsiusTemperature)℃"
    humidityLabel.text = "Humidity\n\(forecastResult.hourForcasts.first!.details.humidity)"
    pressureLabel.text = "Pressure \n\(forecastResult.hourForcasts.first!.details.pressure)"
    windlabel.text = "Wind\n\(forecastResult.hourForcasts.first!.wind.speed)"
  }
  
  func convertFahrenheitToCelsius(tempInFahrenheit: Double) -> Int {
    let celsius = (tempInFahrenheit - 32) * (5/9)
    return Int(celsius)
  }
}

