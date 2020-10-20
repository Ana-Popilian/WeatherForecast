//
//  WeatherForecastView.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit


final class WeatherForecastView: UIView {
  
  private var collectionView: UICollectionView!
  
  private enum ViewTrait {
    static let defaultVerticalSpacing: CGFloat = 50
    static let presureViewWidth: CGFloat = 60
    static let defaultHorizontalSpacing: CGFloat = 20
    static let collectionViewVerticalSpacing: CGFloat = 15
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  func updateForecastData(_ data: ForecastModel) {
//    forecastData = data
//    weatherForFiveDaysCollectionView.reloadData()
//    updateUI(forecastResult: data)
//  }
  
  private let cityNameLabel: UILabel = {
    let name = UILabel()
    name.font = UIFont.systemFont(ofSize: 18)
    name.textColor = .white
    name.textAlignment = .center
    return name
  }()
  
  private let currentTemperatureLabel: UILabel = {
    let temperature = UILabel()
    temperature.font = UIFont.systemFont(ofSize: 16)
    temperature.textColor = .white
    temperature.textAlignment = .center
    return temperature
  }()
  
//  private let humidityView: VisualDescriptiveView = {
//    let image = UIImage(named: "img_humidity")!
//    let view = VisualDescriptiveView(image: image, title: "Humidity")
//    return view
//  }()
//
//  private let pressureView: VisualDescriptiveView = {
//    let image = UIImage(named: "img_pressure")!
//    let view = VisualDescriptiveView(image: image, title: "Pressure")
//    return view
//  }()
//
//  private let windView: VisualDescriptiveView = {
//    let image = UIImage(named: "img_wind")!
//    let view = VisualDescriptiveView(image: image, title: "Wind")
//    return view
//  }()
  
  private let weatherForFiveDaysCollectionView: UICollectionView = {
    let layout = HourForecastViewLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(WeatherForecastForFiveDaysCell.self, forCellWithReuseIdentifier: WeatherForecastForFiveDaysCell.identifier)
    collectionView.backgroundColor = .white
    return collectionView
  }()
}


//extension WeatherForecastView: UICollectionViewDataSource {
  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    guard let forecastData = forecastData else {
//      return 0
//    }
//    return forecastData.hourForcasts.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastForFiveDaysCell.identifier, for: indexPath) as! WeatherForecastForFiveDaysCell
//    let currentHourForecast = forecastData!.hourForcasts[indexPath.row]
//    cell.updateUI(by: currentHourForecast)
//    return cell
//  }
}


//MARK: - Private Zone
private extension WeatherForecastView {
  
  func setupUI() {
    self.backgroundColor = ColorHelper.customGreen
    weatherForFiveDaysCollectionView.dataSource = self
    addSubviews()
    setupConstraints()
  }
  
}


//MARK: - Constraints Zone
private extension WeatherForecastView {
  
  func addSubviews() {
    addSubviewWC(cityNameLabel)
    addSubviewWC(currentTemperatureLabel)

    addSubviewWC(weatherForFiveDaysCollectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTrait.defaultVerticalSpacing),
      cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      cityNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      currentTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      currentTemperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      currentTemperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
     
      weatherForFiveDaysCollectionView.topAnchor.constraint(equalTo: pressureView.bottomAnchor, constant: ViewTrait.collectionViewVerticalSpacing),
      weatherForFiveDaysCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      weatherForFiveDaysCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      weatherForFiveDaysCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
