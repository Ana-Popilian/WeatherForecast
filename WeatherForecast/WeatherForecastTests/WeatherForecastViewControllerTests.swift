//
//  WeatherForecastViewControllerTests.swift
//  WeatherForecastTests
//
//  Created by Ana Popilian on 10/12/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import WeatherForecast


final class ForecastWeatherViewControllerTests: XCTestCase {
    
    private var networkManager: NetworkManagerMock!
    private static let testWeatherModel = makeTestWeatherModel()
    
    private static func makeTestWeatherModel() -> WeatherModel {
        let list = [Detail]()
        let city = City(name: "Test", sunrise: Date(), sunset: Date())
        return WeatherModel(weatherList: list, city: city)
    }
    
    func testGetWeatherDataFailure() {
        let myVC = WeatherForecastViewController(injector: self, mainView: WeatherViewMock())
        XCTAssertNil(myVC.error, "Error should be nil")
        networkManager.resultIsSuccess = true
        myVC.getWeatherData()
        XCTAssertNotNil(myVC.error, "Error should not be nil")
    }
    
    func testGetWeatherDataSuccess() {
        let mainView = WeatherViewMock()
        mainView.expectation = XCTestExpectation(description: "updateWeatherData")
        
        let myVC = WeatherForecastViewController(injector: self, mainView: mainView)
        XCTAssertNil(myVC.weatherData, "Data should be nil")
        networkManager.resultIsSuccess = false
        myVC.getWeatherData()
        XCTAssertNotNil(myVC.weatherData, "Data should not be nil")
        
        wait(for: [mainView.expectation!], timeout: 0.1)
        
        XCTAssertEqual(ForecastWeatherViewControllerTests.testWeatherModel.city.name, mainView.passedWeatherModel.city.name)
    }
    
    func testLastLocation() {
        let myVC = WeatherForecastViewController(injector: self, mainView: WeatherViewMock())
        let locations: [CLLocation] = [CLLocation(latitude: 44.319305, longitude: 23.800678), CLLocation(latitude: 300, longitude: 200)]
        let manager = CLLocationManager()
        
        myVC.locationManager(manager, didUpdateLocations: locations)
        
        let latitudeString = "lat=\(locations.last!.coordinate.latitude)"
        let longitudeString = "lon=\(locations.last!.coordinate.longitude)"
        XCTAssertTrue(networkManager.passedUrl.absoluteString.contains(latitudeString))
        XCTAssertTrue(networkManager.passedUrl.absoluteString.contains(longitudeString))
    }
}


// MARK: - InjectorProtocol
extension ForecastWeatherViewControllerTests: InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        
        networkManager = NetworkManagerMock()
        return networkManager
    }
    
    class NetworkManagerMock: NetworkManagerProtocol {
        var passedUrl: URL!
        var resultIsSuccess = false
        
        func getData<T: Decodable>(of type: T.Type,
                                   from url: URL,
                                   completion: @escaping (Result <T, Error>) -> Void) {
            passedUrl = url
            
            if resultIsSuccess {
                completion(.failure(NSError(domain: "A", code: 1)))
                
            } else {
                completion(.success(ForecastWeatherViewControllerTests.testWeatherModel as! T))
            }
        }
    }
    
    class WeatherViewMock: UIView, WeatherForecastViewProtocol {
        var expectation: XCTestExpectation?
        var passedWeatherModel: WeatherModel!
        
        func updateWeatherData(_ weather: WeatherModel) {
            passedWeatherModel = weather
            expectation?.fulfill()
        }
    }
}
