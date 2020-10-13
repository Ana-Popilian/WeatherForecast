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
  private var weatherData1: WeatherModel!
  private var networkManager = NetworkManager()
  private var latitude: Double!
  private var longitude: Double!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView = MainView()
    view = mainView
    
    getWeatherData()
//    mainView.updateUI(weatherData1)
    //    let parserService = ParserService()
    //    let cities = parserService.parsedCities()
    //    mainView.updateCities(cities)
  }
}

extension ViewController {
  
  func getWeatherData() {
    let appId = "9d4b20529a15bc127ff039cecd2d4793"
    let lat = "52.380457"
    let long = "4.873351"
    let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&units=metric&appid=\(appId)")!
    
    networkManager.getData(of: WeatherModel.self, from: url) { (response) in
      switch response {
        
      case .failure(let error):
        if error is DataError {
          print(error)
        } else {
          print(error.localizedDescription)
        }
        print(error.localizedDescription)
        
      case .success(let weatherData):
  
          print(weatherData)
          self.weatherData1 = weatherData
        }
        DispatchQueue.main.async {
          guard self.weatherData1 != nil else {
            return
          }
          self.mainView.updateWeatherData(self.weatherData1)

        }
      }
    }
}


