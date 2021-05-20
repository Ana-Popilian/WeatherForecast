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
   private let testWeatherModel = makeTestWeatherModel()
   
   private let mainView = WeatherViewMock()
   private var sut: WeatherForecastViewController!
   
   override func setUp() {
      sut = WeatherForecastViewController(injector: self, mainView: mainView)
   }
   
   private static func makeTestWeatherModel() -> WeatherModel {
      let list = [Detail]()
      let city = City(name: "Test", sunrise: Date(), sunset: Date())
      return WeatherModel(weatherList: list, city: city)
   }
   
   func testGetWeatherDataFailure() {
      XCTAssertNil(sut.error, "Error should be nil")
      networkManager = NetworkManagerMock()
      networkManager.getDataExpectation = expectation(description: "getDataExpectation")
      
      sut.getWeatherData()
      wait(for: [networkManager.getDataExpectation!], timeout: 2)
      
      XCTAssertNotNil(sut.error, "Error should not be nil")
   }
   
   func testGetWeatherDataSuccess() {
      mainView.expectation = XCTestExpectation(description: "updateWeatherData")
      XCTAssertNil(sut.weatherData, "Data should be nil")
      
      networkManager = NetworkManagerMock()
      networkManager.successModel = testWeatherModel
      networkManager.getDataExpectation = expectation(description: "getDataExpectation")
      sut.getWeatherData()
      
      wait(for: [mainView.expectation!, networkManager.getDataExpectation!], timeout: 2)
      
      XCTAssertNotNil(sut.weatherData, "Data should not be nil")
      XCTAssertEqual(testWeatherModel.city.name, mainView.passedWeatherModel.city.name)
   }
   
   func testLastLocation() {
      let locations: [CLLocation] = [CLLocation(latitude: 44.319305, longitude: 23.800678), CLLocation(latitude: 300, longitude: 200)]
      let manager = CLLocationManager()
      
      networkManager = NetworkManagerMock()
      sut.locationManager(manager, didUpdateLocations: locations)
      
      let latitudeString = "lat=\(locations.last!.coordinate.latitude)"
      let longitudeString = "lon=\(locations.last!.coordinate.longitude)"
      XCTAssertTrue(networkManager.passedUrl.absoluteString.contains(latitudeString))
      XCTAssertTrue(networkManager.passedUrl.absoluteString.contains(longitudeString))
   }
}


// MARK: - InjectorProtocol
extension ForecastWeatherViewControllerTests: InjectorProtocol {
   
   func makeNetworkManager() -> NetworkManagerProtocol {
      networkManager
   }
   
   final class NetworkManagerMock: NetworkManagerProtocol {
      
      var successModel: WeatherModel?
      var getDataExpectation: XCTestExpectation?
      var passedUrl: URL!
      
      func getData<T: Decodable>(of type: T.Type,
                                 from url: URL,
                                 completion: @escaping (Result <T, Error>) -> Void) {
         
         defer {
            getDataExpectation?.fulfill()
         }
         
         passedUrl = url
         
         guard let successModel = successModel else {
            completion(.failure(NSError(domain: "A", code: 1)))
            return
         }
         
         completion(.success(successModel as! T))
      }
   }
   
   final class WeatherViewMock: UIView, WeatherForecastViewProtocol {
      var expectation: XCTestExpectation?
      var passedWeatherModel: WeatherModel!
      
      func updateWeatherData(_ weather: WeatherModel) {
         passedWeatherModel = weather
         expectation?.fulfill()
      }
   }
}
