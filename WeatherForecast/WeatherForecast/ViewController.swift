//
//  ViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var cities = [City]()
  
  var mainView: MainView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    mainView = MainView()
    mainView.delegate = self
    view = mainView
    
    let cities = parsedCities()
    mainView.updateCities(cities)
  }
  
  private func parsedCities() -> [City] {
    do {
      if let file = Bundle.main.url(forResource: "cityList", withExtension: "json") {
        let data = try Data(contentsOf: file)
        
        let decoder = JSONDecoder()
        let jsonResult = try decoder.decode([City].self, from: data)
        
        return jsonResult
      }
    } catch {
      print(error.localizedDescription)
    }
    return [City]()
  }
}

extension ViewController: MainViewDelegate {
  func didSelectedCity(_ city: City) {
    let nextViewController = WeatherForecastViewController()
    nextViewController.cityID = String(city.id)
   let navController = UINavigationController(rootViewController: nextViewController)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true)
  }
}

