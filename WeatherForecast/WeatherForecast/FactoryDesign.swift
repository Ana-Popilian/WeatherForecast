//
//  FactoryDesign.swift
//  WeatherForecast
//
//  Created by Ana Popilian on 09/12/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

protocol InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol
}

struct AppInjector: InjectorProtocol {
    private init() {}
    
    static let shared = AppInjector()
}


// MARK: - InjectorProtocolExtension
extension InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
}
