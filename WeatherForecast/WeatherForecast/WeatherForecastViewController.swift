//
//  WeatherForecastViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
  
  var mainView: WeatherForecastView!
  var cityID: String!
  
  override func loadView() {
    mainView = WeatherForecastView()
    mainView.delegate = self
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let network = NetworkManager()
    network.getWeatherData(cityId: cityID, completionHandler: { [weak self] (forecastResult) in
      guard let self = self else { return }
      
      self.mainView.forecastData = forecastResult
    })
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
  }
  
  @objc func goBack() {
    self.dismiss(animated: true)
  }
  
}
extension WeatherForecastViewController: WeatherViewDelegate {
}


