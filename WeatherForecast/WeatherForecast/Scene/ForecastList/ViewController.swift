//
//  ViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  private var mainView: MainView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView = MainView(delegate: self)
    view = mainView
    
    let parserService = ParserService()
    let cities = parserService.parsedCities()
    mainView.updateCities(cities)
  }
}

extension ViewController: MainViewDelegate {
  
  func didSelectedCity(_ city: CityModel) {
    let nextViewController = WeatherForecastViewController()
    nextViewController.cityID = String(city.id)
    
    let navController = UINavigationController(rootViewController: nextViewController)
    navController.modalPresentationStyle = .fullScreen
    
    present(navController, animated: true)
  }
}

