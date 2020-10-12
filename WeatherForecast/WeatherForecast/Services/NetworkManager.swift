//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Ana on 12/10/2019.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

enum DataError: Error {
  case invalidResponse
  case invalidData
  case decodingError
  case serverError
}

final class NetworkManager: NSObject {
  
  typealias result<T> = (Result <T, Error>) -> Void
  
  func getData<T: Decodable>(of type: T.Type,
                             from url: URL,
                             completion: @escaping result<T>) {
    
    URLSession.shared.dataTask(with: url) {(data, response, error) in
      if let error = error {
        completion (.failure(error))
        
      }
      
      guard let response = response as? HTTPURLResponse else {
        completion(.failure(DataError.invalidResponse))
        return
      }
      
      if 200 ... 299 ~= response.statusCode {
        if let data = data {
          do {
            let decodedData: T = try JSONDecoder().decode(type, from: data);  completion(.success(decodedData))
          }
          catch {
            completion(.failure(DataError.decodingError))
          }
        } else {
          completion(.failure(DataError.invalidData))
        }
      } else {
        completion(.failure(DataError.serverError))
      }
    } .resume()
  }
}
//final class NetworkManager {
//
//  func getWeatherData(cityId: String, completionHandler: @escaping (_ forecastResult: ForecastModel) -> Void) {
//
//    let apiKey = "&appid=9d4b20529a15bc127ff039cecd2d4793"
//    let api = "http://api.openweathermap.org/data/2.5/forecast?id="
//    let system = "&units=metric"
//    let url = URL(string: api + cityId +  system + apiKey)!
//
//    let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//      do {
//        let decoder = JSONDecoder()
//        let response = try decoder.decode(ForecastModel.self, from: data!)
//
//        completionHandler(response)
//
//      } catch let DecodingError.dataCorrupted(context) {
//        print(context)
//      } catch let DecodingError.keyNotFound(key, context) {
//        print("Key '\(key)' not found:", context.debugDescription)
//        print("codingPath:", context.codingPath)
//      } catch let DecodingError.valueNotFound(value, context) {
//        print("Value '\(value)' not found:", context.debugDescription)
//        print("codingPath:", context.codingPath)
//      } catch let DecodingError.typeMismatch(type, context)  {
//        print("Type '\(type)' mismatch:", context.debugDescription)
//        print("codingPath:", context.codingPath)
//      } catch {
//        print("error: ", error)
//      }
//    }
//    request.resume()
//  }
//}
