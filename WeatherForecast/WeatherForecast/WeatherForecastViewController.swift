//
//  WeatherForecastViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
  
  let gorkaId = 1283378
  var weatherView: WeatherForecastView!
  
  var forecastResult: ForecastResult!
  
  override func loadView() {
    weatherView = WeatherForecastView()
    weatherView.delegate = self
    view = weatherView
    
  //  weatherView.bindView(forecast: forecastResult)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    parsedTemperature()
  }
  
  private func parsedTemperature() -> [ForecastResult] {
    do {
      if let file = Bundle.main.url(forResource: "FiveDayWeather", withExtension: "json") {
        let data = try Data(contentsOf: file)
        
        let decoder = JSONDecoder()
        let jsonResult = try decoder.decode([ForecastResult].self, from: data)
        
        return jsonResult
      }
    } catch {
      print(error.localizedDescription)
    }
       print("I did it")
    return [ForecastResult]()
  }
}

extension WeatherForecastViewController: WeatherViewDelegate {
}

