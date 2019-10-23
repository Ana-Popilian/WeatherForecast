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
  
  private let humidityView: VisualDescriptiveView = {
    let image = UIImage(named: "img_humidity")!
    let view = VisualDescriptiveView(image: image, title: "Humidity")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let pressureView: VisualDescriptiveView = {
    let image = UIImage(named: "img_pressure")!
    let view = VisualDescriptiveView(image: image, title: "Pressure")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let windView: VisualDescriptiveView = {
    let image = UIImage(named: "img_wind")!
    let view = VisualDescriptiveView(image: image, title: "Wind")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  private let weatherForFiveDaysCollectionView: UICollectionViewFlowLayout = {
    let collectionView = UICollectionViewFlowLayout()
    collectionView.scrollDirection = .horizontal
    return collectionView
  }()
  
  
  func setupUI() {
    self.backgroundColor = UIColor(red: 11/255, green: 57/255, blue: 32/255, alpha: 1)
    
    
    addSubview(cityNameLabel)
    addSubview(currentTemperatureLabel)
    addSubview(humidityView)
    addSubview(pressureView)
    addSubview(windView)
    
    //    addSubview(weatherForFiveDaysCollectionView)
    
    NSLayoutConstraint.activate([
      cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
      cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      cityNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 60),
      currentTemperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      currentTemperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      pressureView.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 60),
      pressureView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      pressureView.widthAnchor.constraint(equalToConstant: 60),
      
      humidityView.topAnchor.constraint(equalTo: pressureView.topAnchor),
      humidityView.trailingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: -20),
      humidityView.widthAnchor.constraint(equalTo: pressureView.widthAnchor),
      
      windView.topAnchor.constraint(equalTo: pressureView.topAnchor),
      windView.leadingAnchor.constraint(equalTo: pressureView.trailingAnchor, constant: 20),
      windView.widthAnchor.constraint(equalTo: pressureView.widthAnchor),
      
    ])
  }
  
  func bindView(forecastResult: ForecastResult) -> Void {
    let temp = Int(forecastResult.hourForcasts.first!.details.temperature)
    
    cityNameLabel.text = String(forecastResult.city.name)
    
    
         let celsiusTemperature = convertFahrenheitToCelsius(tempInFahrenheit: Double(temp))
        currentTemperatureLabel.text = "\(celsiusTemperature)℃"
   
    
    humidityView.updateTitle("Humidity\n\(forecastResult.hourForcasts.first!.details.humidity)")
    pressureView.updateTitle("Pressure\n\(forecastResult.hourForcasts.first!.details.pressure)")
    windView.updateTitle("Wind\n\(forecastResult.hourForcasts.first!.wind.speed)")
    
    //    humidityView.text = "Humidity\n\(forecastResult.hourForcasts.first!.details.humidity)"
    //    pressureLabel.text = "Pressure \n\(forecastResult.hourForcasts.first!.details.pressure)"
    //    windlabel.text = "Wind\n\(forecastResult.hourForcasts.first!.wind.speed)"
      }
    
    func convertFahrenheitToCelsius(tempInFahrenheit: Double) -> Int {
      let celsius = (tempInFahrenheit - 32) * (5/9)
      return Int(celsius)
    }
  }
  

