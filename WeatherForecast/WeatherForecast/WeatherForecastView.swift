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
    
    func setupUI() {
      self.backgroundColor = UIColor(red: 11/255, green: 57/255, blue: 32/255, alpha: 1)
      
//      let weatherDetailsStackView = UIStackView(arrangedSubviews: [humidityLabel, pressureLabel, windlabel])
//      weatherDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
//      weatherDetailsStackView.distribution = .fillProportionally
      
      addSubview(cityNameLabel)
      addSubview(currentTemperatureLabel)
      addSubview(humidityLabel)
      addSubview(pressureLabel)
      addSubview(windlabel)
  //    addSubview(weatherForFiveDaysCollectionView)
//      addSubview(weatherDetailsStackView)
      
      NSLayoutConstraint.activate([
        cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
        cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        cityNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        
        currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 60),
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        currentTemperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        
        humidityLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 60),
        humidityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//        humidityLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        
        pressureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 60),
        pressureLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 30),
//        pressureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        
        windlabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 60),
        windlabel.leadingAnchor.constraint(equalTo: pressureLabel.trailingAnchor, constant: 5),
        windlabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
//        weatherDetailsStackView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 30),
//        weatherDetailsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//        weatherDetailsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        
  //      weatherForFiveDaysCollectionView.topAnchor.constraint(equalTo: weatherDetailsStackView.bottomAnchor, constant: 50),
  //      weatherForFiveDaysCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
  //      weatherForFiveDaysCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
  //      weatherForFiveDaysCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      ])
    }
  }

