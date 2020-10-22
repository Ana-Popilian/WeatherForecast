//
//  MainView.swift
//  WeatherForecast
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit


final class MainView: UIView {
  
  private var cityNameLabel: UILabel!
  private var containerView: UIView!
  private var temperatureLabel: UILabel!
  private var descriptionImageView: UIImageView!
  private var descriptionLabel: UILabel!
  private var humidityImageView: UIImageView!
  private var humidityLabel: UILabel!
  private var windImageView: UIImageView!
  private var windLabel: UILabel!
  private var pressureImageView: UIImageView!
  private var pressureLabel: UILabel!
  private var segmentControl: UISegmentedControl!
  private var tableView: UITableView!
  private var collectionView: UICollectionView!
  
  private var todayData: [Detail]!
  private var weatherData: WeatherModel!
  
  private enum ViewTrait {
    static let heightMultiplier: CGFloat = 0.5
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
    tableView.reloadData()
    cityNameLabel.text = weather.city.name
    let temp = Int(weather.weatherList.first!.tempInfo.temp)
    temperatureLabel.text = "\(temp)℃"
    
    guard let image = weather.weatherList.first?.weather.first?.icon else {
      return
    }
    descriptionImageView.downloadImage(name: image, downloadFinishedHandler: {
    })
    
    descriptionLabel.text = "\(weather.weatherList.first!.weather.first!.description)"
    humidityLabel.text = "\(weather.weatherList.first!.tempInfo.humidity)%"
    windLabel.text = "\(weather.weatherList.first!.wind.speed)m/s"
    pressureLabel.text = "\(weather.weatherList.first!.tempInfo.pressure)hPA"
  }
  
  func filterTodayWeatherData() {
    let calendar = Calendar.current
    let weekOfYear = calendar.component(.weekday, from: Date())
    
    guard weatherData != nil else {
      return
    }
    
    var todayForecast: [Detail] = []
    for element in weatherData.weatherList {

      let weekOfYearForElement = calendar.component(.weekday, from: element.date)

      if weekOfYearForElement == weekOfYear {
        todayForecast.append(element)

      }
        todayData = todayForecast
      
//      todayForecast = weatherData.weatherList.filter { (element) -> Bool in
//        let weekDayForElement = calendar.component(.weekday, from: element.date)
//
//       return weekDayForElement == weekOfYear
      }
    }
  }


//MARK: - Private Zone
private extension MainView {
  
  func setupUI() {
    backgroundColor = .white
    
    //    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
    setupCityName()
    setupContainer()
    setupTemperatureLabel()
    setupDescriptionImageView()
    setupDescriptionLabel()
    setupHumidityImageView()
    setupHumidityLabel()
    setupWindImageView()
    setupWindLabel()
    setupPressureImageView()
    setupPressureLabel()
    setupSegmentControl()
    setupTableView()
    setupCollectionView()
    
    addSubviews()
    setupConstraints()
  }
  
  func setupCityName() {
    let font = UIFont.systemFont(ofSize: 20)
    cityNameLabel = UILabel(text: "Amsterdam", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupContainer() {
    containerView = UIView()
  }
  
  func setupTemperatureLabel() {
    let font = UIFont.systemFont(ofSize: 20)
    temperatureLabel = UILabel(text: "13℃", font: font, textAlignment: .left, textColor: .black)
  }
  
  func setupDescriptionImageView() {
    let image = UIImage(named: "img_humidity")!
    descriptionImageView = UIImageView(image: image)
  }
  
  func setupDescriptionLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    descriptionLabel = UILabel(text: "Light rain", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupHumidityImageView() {
    let image = UIImage(named: "img_humidity")!
    humidityImageView = UIImageView(image: image)
  }
  
  func setupHumidityLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    humidityLabel = UILabel(text: "91%", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupWindImageView() {
    let image = UIImage(named: "img_wind")!
    windImageView = UIImageView(image: image)
  }
  
  func setupWindLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    windLabel = UILabel(text: "8.2 m/s", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupPressureImageView() {
    let image = UIImage(named: "img_pressure")!
    pressureImageView = UIImageView(image: image)
  }
  
  func setupPressureLabel() {
    let font = UIFont.systemFont(ofSize: 14)
    pressureLabel = UILabel(text: "998 hPa", font: font, textAlignment: .center, textColor: .black)
  }
  
  func setupSegmentControl() {
    let items = ["Today", "Next days"]
    segmentControl = UISegmentedControl(items: items)
    segmentControl.selectedSegmentIndex = 0
    segmentControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    
    segmentControl.layer.cornerRadius = 5.0
    segmentControl.backgroundColor = .systemBlue
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
    collectionView.backgroundColor = .red
    collectionView.dataSource = self
  }

  //  func filterCityByName(typedWord: String, myCities: [CityModel]) -> [CityModel] {
  //    return myCities.filter { $0.name.contains(typedWord) }
  //  }
}


// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    filterTodayWeatherData()
    if todayData == nil {
      return 0
    } else {
      return todayData.count //weatherData.weatherList.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
    let data = todayData[indexPath.row] //weatherData.weatherList[indexPath.row]
    cell.bindCell(data)
    
    return cell
  }
}


// MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
  
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


//MARK: - UISearchBarDelegate
//extension MainView: UISearchBarDelegate {
//
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    let filterResult = filterCityByName(typedWord: searchText, myCities: cities)
//    filteredCities = filterResult
//    tableView.reloadData()
//  }
//}


//MARK: - Constraints Zone
private extension MainView {
  
  func addSubviews() {
    addSubviewWC(cityNameLabel)
    addSubviewWC(containerView)
    containerView.addSubviewWC(temperatureLabel)
    containerView.addSubviewWC(descriptionImageView)
    containerView.addSubviewWC(descriptionLabel)
    containerView.addSubviewWC(humidityImageView)
    containerView.addSubviewWC(humidityLabel)
    containerView.addSubviewWC(windImageView)
    containerView.addSubviewWC(windLabel)
    containerView.addSubviewWC(pressureImageView)
    containerView.addSubviewWC(pressureLabel)
    addSubviewWC(segmentControl)
    addSubviewWC(tableView)
    addSubviewWC(collectionView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      cityNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      cityNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      
      containerView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      temperatureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
      temperatureLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      
      descriptionImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
      descriptionImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      descriptionImageView.heightAnchor.constraint(equalToConstant: 35),
      descriptionImageView.widthAnchor.constraint(equalToConstant: 35),
      
      descriptionLabel.leadingAnchor.constraint(equalTo: descriptionImageView.trailingAnchor, constant: 20),
      descriptionLabel.centerYAnchor.constraint(equalTo: descriptionImageView.centerYAnchor),
      
      humidityImageView.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 5),
      humidityImageView.leadingAnchor.constraint(equalTo: descriptionImageView.leadingAnchor),
      humidityImageView.heightAnchor.constraint(equalToConstant: 25),
      humidityImageView.widthAnchor.constraint(equalToConstant: 25),
      
      humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 20),
      humidityLabel.centerYAnchor.constraint(equalTo: humidityImageView.centerYAnchor),
      
      windImageView.topAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 5),
      windImageView.leadingAnchor.constraint(equalTo: descriptionImageView.leadingAnchor),
      windImageView.heightAnchor.constraint(equalToConstant: 25),
      windImageView.widthAnchor.constraint(equalToConstant: 25),
      
      windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 20),
      windLabel.centerYAnchor.constraint(equalTo: windImageView.centerYAnchor),
      
      pressureImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 10),
      pressureImageView.leadingAnchor.constraint(equalTo: descriptionImageView.leadingAnchor),
      pressureImageView.heightAnchor.constraint(equalToConstant: 25),
      pressureImageView.widthAnchor.constraint(equalToConstant: 25),
      
      pressureLabel.leadingAnchor.constraint(equalTo: pressureImageView.trailingAnchor, constant: 20),
      pressureLabel.centerYAnchor.constraint(equalTo: pressureImageView.centerYAnchor),
      pressureLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      segmentControl.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 15),
      segmentControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
      segmentControl.heightAnchor.constraint(equalToConstant: 30),
      
      collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
      tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
  
    ])
  }
}
