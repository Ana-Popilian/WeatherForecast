//
//  WeatherForecastViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.


import UIKit

final class WeatherForecastViewController: UIViewController {
  
  private var mainView: WeatherForecastView!
  
  
  override func loadView() {
    mainView = WeatherForecastView()
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
}

