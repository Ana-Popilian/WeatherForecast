//
//  WeatherForecastView.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit


final class WeatherForecastView: UIView {
  
  private var dayLabel: UILabel!
  private var collectionView: UICollectionView!
  
  private var forecastData: WeatherModel!
  
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
  
}


// MARK: - UICollectionViewDataSource
extension WeatherForecastView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
//    guard let forecastData = forecastData else {
//      return 0
//    }
//    return forecastData.weatherList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastForFiveDaysCell.identifier, for: indexPath) as! WeatherForecastForFiveDaysCell
//    let currentHourForecast = forecastData!.weatherList[indexPath.row]
//    cell.updateUI(by: currentHourForecast)
    return cell
  }
}


//MARK: - Private Zone
private extension WeatherForecastView {
  
  func setupUI() {
    self.backgroundColor = .white
    
    setupDayLabel()
    setupCollectionView()
    
    addSubviews()
    setupConstraints()
  }
  
  func setupDayLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    dayLabel = UILabel(text: "Wednesday", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupCollectionView() {
    let layout = HourForecastViewLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(WeatherForecastForFiveDaysCell.self, forCellWithReuseIdentifier: WeatherForecastForFiveDaysCell.identifier)
    collectionView.backgroundColor = .red
    collectionView.dataSource = self
  }
}


//MARK: - Constraints Zone
private extension WeatherForecastView {
  
  func addSubviews() {
    addSubviewWC(dayLabel)
    addSubviewWC(collectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      dayLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      dayLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      
      collectionView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
