//
//  CityCell.swift
//  WeatherForecast
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class TodayForecastTableViewCell: UITableViewCell, Identifiable {
    
    private var hourLabel: UILabel!
    private var temperatureLabel: UILabel!
    private var weatherImage: UIImageView!
    
    private enum VT {
        static let defaultPadding: CGFloat = 20
        static let imageSize: CGFloat = 40
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupUI()
        accessibilityIdentifier = "todayForecast-cell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindCell(_ data: Detail) {
        hourLabel.text = data.date.asString(style: .short)
        
        let temp = Int(data.tempInfo.temp)
        temperatureLabel.text = "\(temp)℃"
        
        guard let image = data.weather.first?.icon else {
            return
        }
        weatherImage.downloadImage(name: image, downloadFinishedHandler: {
        })
    }
}


//MARK: - Private Zone
private extension TodayForecastTableViewCell {
    
    func setupUI() {
        setupHourLabel()
        setupTemperatureLabel()
        setupWeatherImage()
        
        addSubview()
        setupConstraints()
    }
    
    func setupHourLabel() {
        let font = UIFont.systemFont(ofSize: 13)
        hourLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
        hourLabel.accessibilityIdentifier = "hour-label"
    }
    
    func setupTemperatureLabel() {
        let font = UIFont.systemFont(ofSize: 13)
        temperatureLabel = UILabel(font: font, textAlignment: .natural, textColor: .black)
        temperatureLabel.accessibilityIdentifier = "temperature-label"
    }
    
    func setupWeatherImage() {
        weatherImage = UIImageView()
        weatherImage.accessibilityIdentifier = "cell-image"
    }
}


//MARK: - Constraints Zone
private extension TodayForecastTableViewCell {
    
    func addSubview() {
        addSubviewWC(hourLabel)
        addSubviewWC(temperatureLabel)
        addSubviewWC(weatherImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            hourLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            hourLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: VT.defaultPadding),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -VT.defaultPadding),
            weatherImage.heightAnchor.constraint(equalToConstant: VT.imageSize),
            weatherImage.widthAnchor.constraint(equalToConstant: VT.imageSize),
        ])
    }
}
