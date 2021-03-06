//
//  WeatherForecastCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class NextDaysForecastCollectionViewCell: UICollectionViewCell, Identifiable {
    
    private var hourLabel: UILabel!
    private var temperatureLabel: UILabel!
    private var forecastImage: UIImageView!
    
    private enum ViewTrait {
        static let cornerRadius: CGFloat = 15
        static let defaultVerticalSpacing: CGFloat = 5
        static let imageSize: CGFloat = 40
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = ViewTrait.cornerRadius
        backgroundColor = ColorHelper.customBlue
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindCell(by hourForecast: Detail) {
        
        hourLabel.text = hourForecast.date.asString(style: .full)
        let temp = Int(hourForecast.tempInfo.temp)
        temperatureLabel.text = "\(temp)℃"
        
        guard let image = hourForecast.weather.first?.icon else {
            return
        }
        forecastImage.downloadImage(name: image)
    }
}


// MARK: - Private Zone
private extension NextDaysForecastCollectionViewCell {
    
    func setupUI() {
        setupHourLabel()
        setupForecastImage()
        setupTemperatureLabel()
        
        addSubviews()
        setupConstraints()
    }
    
    func setupHourLabel() {
        let font = UIFont.systemFont(ofSize: 13)
        hourLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
        hourLabel.accessibilityIdentifier = "nextDays-hour"
    }
    
    func setupForecastImage() {
        forecastImage = UIImageView()
    }
    
    func setupTemperatureLabel() {
        let font = UIFont.systemFont(ofSize: 13)
        temperatureLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
        temperatureLabel.accessibilityIdentifier = "nextDays-temperature"
    }
}


//MARK: - Constraints Zone
private extension NextDaysForecastCollectionViewCell {
    
    func addSubviews() {
        addSubviewWC(hourLabel)
        addSubviewWC(forecastImage)
        addSubviewWC(temperatureLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultVerticalSpacing),
            hourLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            forecastImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            forecastImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            forecastImage.widthAnchor.constraint(equalToConstant: ViewTrait.imageSize),
            forecastImage.heightAnchor.constraint(equalToConstant: ViewTrait.imageSize),
            
            temperatureLabel.topAnchor.constraint(equalTo: forecastImage.bottomAnchor, constant:ViewTrait.defaultVerticalSpacing),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultVerticalSpacing)
        ])
    }
}
