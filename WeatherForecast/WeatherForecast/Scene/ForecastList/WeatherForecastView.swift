//
//  MainView.swift
//  WeatherForecast
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class WeatherForecastView: UIView {
  
  private var topView: TopWeatherView!
  private var segmentControl: UISegmentedControl!
  private var todayForecastTableView: UITableView!
  private var nextDaysForecastTableView: UITableView!
  
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
    nextDaysForecastTableView.reloadData()
    filterTodayWeatherData()
    todayForecastTableView.reloadData()
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
private extension WeatherForecastView {
  
  func setupUI() {
    backgroundColor = .white
    setupTopView()
    setupSegmentControl()
    setupTableView()
    setupNextDaysForecastTableView()
    
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
      todayForecastTableView.isHidden = false
      nextDaysForecastTableView.isHidden = true
    case 1:
      nextDaysForecastTableView.reloadData()
      todayForecastTableView.isHidden = true
      nextDaysForecastTableView.isHidden = false
    default:
      break
    }
  }
  
  func setupTableView() {
    todayForecastTableView = UITableView()
    todayForecastTableView.register(TodayForecastTableViewCell.self, forCellReuseIdentifier: TodayForecastTableViewCell.identifier)
    todayForecastTableView.dataSource = self
  }
  
  func setupNextDaysForecastTableView() {
    nextDaysForecastTableView = UITableView()
    nextDaysForecastTableView.register(NextDaysForecastTableViewCell.self, forCellReuseIdentifier: NextDaysForecastTableViewCell.identifier)
//    nextDaysForecastTableView.separatorStyle = .none
    nextDaysForecastTableView.rowHeight = 120
    nextDaysForecastTableView.dataSource = self
  }
}


// MARK: - UITableViewDataSource
extension WeatherForecastView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard (todayData != nil), nextDaysData != nil else {
      return 0
    }
    //    return todayData.count
    if tableView == todayForecastTableView {
      return todayData.count
    } else {
//      return nextDaysData.count
      return 4
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == todayForecastTableView {
      let cell = tableView.dequeueReusableCell(withIdentifier: TodayForecastTableViewCell.identifier, for: indexPath) as! TodayForecastTableViewCell
      let data = todayData[indexPath.row]
      cell.bindCell(data)
      
      return cell
      
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: NextDaysForecastTableViewCell.identifier, for: indexPath) as! NextDaysForecastTableViewCell
//      let data = nextDaysData[indexPath.row]
//      cell.bindCell(by: data)
      
      return cell
    }
  }
}


//MARK: - Constraints Zone
private extension WeatherForecastView {
  
  func addSubviews() {
    addSubviewWC(topView)
    addSubviewWC(segmentControl)
    addSubviewWC(nextDaysForecastTableView)
    addSubviewWC(todayForecastTableView)
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
      
      nextDaysForecastTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: ViewTrait.verticalSpacing),
      nextDaysForecastTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      nextDaysForecastTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      nextDaysForecastTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      todayForecastTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: ViewTrait.verticalSpacing),
      todayForecastTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      todayForecastTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      todayForecastTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}