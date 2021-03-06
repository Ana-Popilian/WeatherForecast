//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherForecastViewController: UIViewController {
   
   private let locationManager = CLLocationManager()
   private var latitude: Double = 0
   private var longitude: Double = 0
   var error: Error?
   
   private let mainView: WeatherForecastViewProtocol
   var weatherData: WeatherModel!
   private let injector: InjectorProtocol
   
   init(injector: InjectorProtocol, mainView: WeatherForecastViewProtocol) {
      self.injector = injector
      self.mainView = mainView
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view = mainView
      
      checkLocationServices()
   }
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
      .darkContent
   }
   
   func setupLocationManager() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
   }
   
   func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
         setupLocationManager()
         checkLocationAuthorization()
      } else {
         showAlert()
      }
   }
}


// MARK: - Private Zone
private extension WeatherForecastViewController {
   
   func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse,
           .authorizedAlways:
         locationManager.requestLocation()
         
      case .denied,
           .restricted:
         showAlert()
         
      case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
         
      @unknown default:
         break
      }
   }
   
   func showAlert() {
      let alertController = UIAlertController(title: "Location Permission is required", message: "Location access is restricted. In order to discover weather information, please share your location", preferredStyle: UIAlertController.Style.alert)
      let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
         
         UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
      })
      
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
      alertController.addAction(cancelAction)
      alertController.addAction(okAction)
      
      present(alertController, animated: true)
   }
}


// MARK: - WeatherForecastViewControllerExtension
extension WeatherForecastViewController {
   
   func getWeatherData() {
      let appId = "9d4b20529a15bc127ff039cecd2d4793"
      
      let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(appId)")!
      
      let networkManager = injector.makeNetworkManager()
      networkManager.getData(of: WeatherModel.self, from: url) { [self] (response) in
         switch response {
         
         case let .failure(error):
            self.error = error
            
         case let .success(forecastData):
            weatherData = forecastData
            
            DispatchQueue.main.async { [self] in
               mainView.updateWeatherData(weatherData)
            }
         }
      }
   }
}


// MARK: - CLLocationManagerDelegate
extension WeatherForecastViewController: CLLocationManagerDelegate {
   
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      checkLocationAuthorization()
   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
      if locations.isEmpty {
         return
      }
      latitude = locations.last?.coordinate.latitude ?? 0
      longitude = locations.last?.coordinate.longitude ?? 0
      
      getWeatherData()
   }
   
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error.localizedDescription)
   }
}
