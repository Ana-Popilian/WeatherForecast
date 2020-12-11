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

protocol NetworkManagerProtocol {
    
    func getData<T: Decodable>(of type: T.Type,
                               from url: URL,
                               completion: @escaping (Result <T, Error>) -> Void)
}


final class NetworkManager: NetworkManagerProtocol {

    func getData<T: Decodable>(of type: T.Type,
                               from url: URL,
                               completion: @escaping (Result <T, Error>) -> Void) {
        
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
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let decodedData: T = try decoder.decode(type, from: data);  completion(.success(decodedData))
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
