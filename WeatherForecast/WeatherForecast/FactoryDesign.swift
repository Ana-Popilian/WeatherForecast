//
//  FactoryDesign.swift
//  WeatherForecast
//
//  Created by Ana Popilian on 09/12/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

protocol ViewControllerFactory {
    func makeViewController() -> WeatherForecastViewController
}

protocol InjectorViewControllerProtocol where Self: UIViewController {
    
}

protocol InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol
}

struct AppInjector: InjectorProtocol {
    private init() {}
    
    static let shared = AppInjector()
}

extension InjectorProtocol {
    func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
}

//extension ViewControllerFactory {
//    func makeViewController() -> WeatherForecastViewController {
//        return WeatherForecastViewController(injector: <#T##InjectorProtocol#>, mainView: WeatherForecastView())
//    }
//}
