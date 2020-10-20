//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController {
  private let locationManager = CLLocationManager()
   private var latitude: Double = 0
   private var longitude: Double = 0
  
  private var mainView: MainView!
  private var weatherData1: WeatherModel!
  private var networkManager = NetworkManager()
//  private var latitude: Double!
//  private var longitude: Double!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView = MainView()
    view = mainView
    
    checkLocationServices()
//    getLocation()
    getWeatherData()
    
    
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
  
  func getLocation() {
    guard let location = locationManager.location else {
      return
    }
    latitude = location.coordinate.latitude
    longitude = location.coordinate.longitude
  }
}


// MARK: - Private Zone
private extension ViewController {
  
  func checkLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
      break
    case .denied:
      showAlert()
      break
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted:
      break
    case .authorizedAlways:
      break
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
    
    self.present(alertController, animated: true, completion: nil)
  }
}

extension ViewController {
  
  func getWeatherData() {
    getLocation()
    let appId = "9d4b20529a15bc127ff039cecd2d4793"
//    let lat = "52.380457"
//    let long = "4.873351"
    let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(appId)")!
    
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


// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkLocationAuthorization()
  }
}
