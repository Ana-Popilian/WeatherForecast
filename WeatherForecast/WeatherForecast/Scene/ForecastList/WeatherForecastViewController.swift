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
    
    private var mainView: WeatherForecastView!
    private var weatherData: WeatherModel!
    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = WeatherForecastView()
        view = mainView
        
        checkLocationServices()
        getWeatherData()
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
    
    func getLocation() {
        guard let location = locationManager.location else {
            return
        }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}


// MARK: - Private Zone
private extension WeatherForecastViewController {
    
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

extension WeatherForecastViewController {
    
    func getWeatherData() {
        getLocation()
        let appId = "9d4b20529a15bc127ff039cecd2d4793"
        
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
                
            case .success(let forecastData):
                
                self.weatherData = forecastData
            }
            DispatchQueue.main.async {
                guard self.weatherData != nil else {
                    return
                }
                self.mainView.updateWeatherData(self.weatherData)
            }
        }
    }
}


// MARK: - CLLocationManagerDelegate
extension WeatherForecastViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
