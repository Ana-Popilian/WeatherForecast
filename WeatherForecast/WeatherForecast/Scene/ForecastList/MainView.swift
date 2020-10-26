//
//  MainView.swift
//  WeatherForecast
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class MainView: UIView {
  
  private var topView: TopWeatherView!
  private var segmentControl: UISegmentedControl!
  private var tableView: UITableView!
  private var collectionView: UICollectionView!
  
  private var todayData: [Detail]!
  private var nextDaysData: [Detail]!
  private var weatherData: WeatherModel!
  
  private enum ViewTrait {
    static let heightMultiplier: CGFloat = 0.4
    static let segmentHeight: CGFloat = 30
    static let horizontalSpacing: CGFloat = 15
    static let verticalSpacing: CGFloat = 10
  }
  
  required init() {
    super.init(frame: .zero)
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateWeatherData(_ weather: WeatherModel) {
    weatherData = weather
    filteNextDaysWeatherData()
    collectionView.reloadData()
    filterTodayWeatherData()
    tableView.reloadData()
    topView.cityNameLabel.text = weather.city.name
    let temp = Int(weather.weatherList.first!.tempInfo.temp)
    topView.temperatureLabel.text = "\(temp)℃"
    
    guard let image = weather.weatherList.first?.weather.first?.icon else {
      return
    }
    topView.descriptionImageView.downloadImage(name: image, downloadFinishedHandler: {
    })
    
    topView.descriptionLabel.text = "\(weather.weatherList.first!.weather.first!.description)"
    topView.humidityLabel.text = "\(weather.weatherList.first!.tempInfo.humidity)%"
    topView.windLabel.text = "\(weather.weatherList.first!.wind.speed)m/s"
    topView.pressureLabel.text = "\(weather.weatherList.first!.tempInfo.pressure)hPA"
  }
  
  func filterTodayWeatherData() {
    let calendar = Calendar.current
    let weekDay = calendar.component(.weekday, from: Date())
    
    guard weatherData != nil else {
      return
    }
    
    var todayForecast: [Detail] = []
    todayForecast = weatherData.weatherList.filter { (element) -> Bool in
      let weekDayForElement = calendar.component(.weekday, from: element.date)
      
      return weekDayForElement == weekDay
    }
    todayData = todayForecast
  }
  
  func filteNextDaysWeatherData() {
    let calendar = Calendar.current
    let weekDay = calendar.component(.weekday, from: Date())
    
    guard weatherData != nil else {
      return
    }
    
    var nextDaysForecast: [Detail] = []
    nextDaysForecast = weatherData.weatherList.filter { (element) -> Bool in
      let weekDayForElement = calendar.component(.weekday, from: element.date)
      return weekDayForElement != weekDay
    }
    nextDaysData = nextDaysForecast
  }
}


//MARK: - Private Zone
private extension MainView {
  
  func setupUI() {
    backgroundColor = .white
    setupTopView()
    setupSegmentControl()
    setupTableView()
    setupCollectionView()
    
    addSubviews()
    setupConstraints()
  }
  
  func setupTopView() {
    topView = TopWeatherView()
  }
  
  func setupSegmentControl() {
    let items = ["Today", "Next days"]
    segmentControl = UISegmentedControl(items: items)
    segmentControl.selectedSegmentIndex = 0
    segmentControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    
    segmentControl.layer.cornerRadius = 5.0
    segmentControl.backgroundColor = ColorHelper.customGreen
  }
  
  @objc func indexChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex{
    case 0:
      tableView.isHidden = false
      collectionView.isHidden = true
    case 1:
      tableView.isHidden = true
      collectionView.isHidden = false
    default:
      break
    }
  }
  
  func setupTableView() {
    tableView = UITableView()
    tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
    tableView.dataSource = self
  }
  
  func setupCollectionView() {
    let layout = HourForecastViewLayout()
    layout.scrollDirection = .horizontal
    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(WeatherForecastForFiveDaysCell.self, forCellWithReuseIdentifier: WeatherForecastForFiveDaysCell.identifier)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
  }
}


// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard todayData != nil else {
      return 0
    }
    return todayData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
    let data = todayData[indexPath.row]
    cell.bindCell(data)
    
    return cell
  }
}


// MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard nextDaysData != nil else {
      return 0
    }
    return nextDaysData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastForFiveDaysCell.identifier, for: indexPath) as! WeatherForecastForFiveDaysCell
    let hourForecast = nextDaysData[indexPath.row]
    cell.bindCell(by: hourForecast)
    return cell
  }
}


//MARK: - Constraints Zone
private extension MainView {
  
  func addSubviews() {
    addSubviewWC(topView)
    addSubviewWC(segmentControl)
    addSubviewWC(collectionView)
    addSubviewWC(tableView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      topView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: ViewTrait.heightMultiplier),
      
      segmentControl.topAnchor.constraint(equalTo: topView.bottomAnchor),
      segmentControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTrait.horizontalSpacing),
      segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.horizontalSpacing),
      segmentControl.heightAnchor.constraint(equalToConstant: ViewTrait.segmentHeight),
      
      collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: ViewTrait.verticalSpacing),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: ViewTrait.verticalSpacing),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}
