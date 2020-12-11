//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let nextViewController = WeatherForecastViewController(injector: AppInjector.shared, mainView: WeatherForecastView())
        window?.rootViewController = nextViewController
        window?.makeKeyAndVisible()
        return true
    }
}
