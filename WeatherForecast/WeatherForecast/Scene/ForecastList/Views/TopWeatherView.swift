//
//  TopWeatherView.swift
//  WeatherForecast
//
//  Created by Ana on 26/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

final class TopWeatherView: UIView {
    
    var cityNameLabel: UILabel!
    var containerView: UIView!
    var temperatureLabel: UILabel!
    var descriptionImageView: UIImageView!
    var descriptionLabel: UILabel!
    var humidityLabel: UILabel!
    var windLabel: UILabel!
    var pressureLabel: UILabel!
    var sunriseLabel: UILabel!
    var sunsetLabel: UILabel!
    
    private enum VT {
        static let verticalSpacing: CGFloat = 10
        static let containerVerticalPadding: CGFloat = 25
        static let horizontalPadding: CGFloat = 50
        static let imageSize: CGFloat = 40
    }
    
    required init() {
        super.init(frame: .zero)
        
        setupUI()
        
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private Zone
private extension TopWeatherView {
    
    func setupUI() {
        setupCityName()
        setupContainer()
        setupTemperatureLabel()
        setupDescriptionImageView()
        setupDescriptionLabel()
        setupHumidityLabel()
        setupWindLabel()
        setupPressureLabel()
        setupSunriseLabel()
        setupSunsetLabel()
    }
    
    func setupCityName() {
        let font = UIFont.systemFont(ofSize: 20)
        cityNameLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
        cityNameLabel.accessibilityIdentifier = "city-label"
    }
    
    func setupContainer() {
        containerView = UIView()
    }
    
    func setupTemperatureLabel() {
        let font = UIFont.systemFont(ofSize: 20)
        temperatureLabel = UILabel(font: font, textAlignment: .left, textColor: .black)
        temperatureLabel.accessibilityIdentifier = "todayTemperature-label"
    }
    
    func setupDescriptionImageView() {
        descriptionImageView = UIImageView()
        descriptionImageView.accessibilityIdentifier = "description-image"
    }
    
    func setupDescriptionLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        descriptionLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
        descriptionLabel.accessibilityIdentifier = "weather-description"
    }
    
    func setupHumidityLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        humidityLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
        humidityLabel.accessibilityIdentifier = "humidity-label"
    }
    
    func setupWindLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        windLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
        windLabel.accessibilityIdentifier = "wind-label"
    }
    
    func setupPressureLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        pressureLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
        pressureLabel.accessibilityIdentifier = "pressure-label"
    }
    
    func setupSunriseLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        sunriseLabel = UILabel( font: font, textAlignment: .center, textColor: .black)
        sunriseLabel.accessibilityIdentifier = "sunrise-label"
    }
    
    func setupSunsetLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        sunsetLabel = UILabel( font: font, textAlignment: .center, textColor: .black)
        sunsetLabel.accessibilityIdentifier = "sunset-label"
    }
}


// MARK: - Constraints Zone
private extension TopWeatherView {
    
    func addSubViews() {
        addSubviewWC(cityNameLabel)
        addSubviewWC(containerView)
        containerView.addSubviewWC(temperatureLabel)
        containerView.addSubviewWC(descriptionImageView)
        containerView.addSubviewWC(descriptionLabel)
        containerView.addSubviewWC(humidityLabel)
        containerView.addSubviewWC(windLabel)
        containerView.addSubviewWC(pressureLabel)
        containerView.addSubviewWC(sunriseLabel)
        containerView.addSubviewWC(sunsetLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: VT.verticalSpacing),
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: VT.containerVerticalPadding),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: VT.horizontalPadding),
            descriptionImageView.heightAnchor.constraint(equalToConstant: VT.imageSize),
            descriptionImageView.widthAnchor.constraint(equalToConstant: VT.imageSize),
            
            temperatureLabel.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: descriptionImageView.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: VT.verticalSpacing),
            descriptionLabel.centerXAnchor.constraint(equalTo: descriptionImageView.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            windLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: VT.verticalSpacing),
            windLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: VT.verticalSpacing),
            pressureLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            sunriseLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: VT.verticalSpacing),
            sunriseLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: VT.verticalSpacing),
            sunsetLabel.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            sunsetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
