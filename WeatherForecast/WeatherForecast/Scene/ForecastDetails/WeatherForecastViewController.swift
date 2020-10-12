//
//  WeatherForecastViewController.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

//import UIKit
//
//final class WeatherForecastViewController: UIViewController {
//  
//  private var mainView: WeatherForecastView!
//  var cityID: String!
//  
//  override func loadView() {
//    mainView = WeatherForecastView()
//    view = mainView
//  }
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    let network = NetworkManager()
//    network.getWeatherData(cityId: cityID, completionHandler: { [weak self] (forecastResult) in
//      guard let self = self else { return }
//      
//      DispatchQueue.main.async {
//        self.mainView.updateForecastData(forecastResult)
//      }
//    })
//    
//    let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"),
//                                     style: .plain,
//                                     target: self,
//                                     action: #selector(goBack))
//    navigationItem.leftBarButtonItem = backButton
//  }
//  
//  @objc func goBack() {
//    self.dismiss(animated: true)
//  }
//}
//
//
