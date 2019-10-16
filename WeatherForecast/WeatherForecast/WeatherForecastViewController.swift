//
//  WeatherForecastViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
  
  var weatherView: WeatherForecastView!
  
  override func loadView() {
    weatherView = WeatherForecastView()
    weatherView.delegate = self
    
    view = weatherView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension WeatherForecastViewController: WeatherViewDelegate {
  
}

