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
  
  var forecastResult: ForecastResult!
   var forecastData = [ForecastResult]()
  
  override func loadView() {
    weatherView = WeatherForecastView()
    weatherView.delegate = self
    view = weatherView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    let forecastResult = parsedTemperature()
    //    if let result = forecastResult {
    //      weatherView.bindView(forecastResult: result)
    let network = NetworkManager()
    network.getWeatherData{ [weak self] (forecastResult) in
      guard let unwrappedResult = forecastResult else { return }
      guard let self = self else { return }
      self.forecastData = [unwrappedResult]
      
      //                print(forecastResult)
      
      DispatchQueue.main.async {
//        view.weatherForFiveDaysCollectionView.reloadData()
      }
    }
  }
  
//
//  private func parsedTemperature() -> ForecastResult? {
//    do {
//      if let file = Bundle.main.url(forResource: "FiveDayWeather", withExtension: "json") {
//        let data = try Data(contentsOf: file)
//
//        let decoder = JSONDecoder()
//        let result = try decoder.decode(ForecastResult.self, from: data)
//        //        print(result)
//        return result
//
//      }
//      //    } catch {
//      //      print(error.localizedDescription)
//    } catch let DecodingError.dataCorrupted(context) {
//      print(context)
//    } catch let DecodingError.keyNotFound(key, context) {
//      print("Key '\(key)' not found:", context.debugDescription)
//      print("codingPath:", context.codingPath)
//    } catch let DecodingError.valueNotFound(value, context) {
//      print("Value '\(value)' not found:", context.debugDescription)
//      print("codingPath:", context.codingPath)
//    } catch let DecodingError.typeMismatch(type, context)  {
//      print("Type '\(type)' mismatch:", context.debugDescription)
//      print("codingPath:", context.codingPath)
//    } catch {
//      print("error: ", error)
//    }
//    return nil
//  }
}

extension WeatherForecastViewController: WeatherViewDelegate {
}


