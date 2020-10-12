//
//  MainView.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit
import MapKit

protocol MainViewDelegate : class {
  
  func didSelectedCity(_ city: CityModel)
}

final class MainView: UIView {
  
  private weak var delegate : MainViewDelegate?
  
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
  
  
  private var filteredCities = [CityModel]()
  private var cities = [CityModel]()
  
  private enum ViewTrait {
    static let heightMultiplier: CGFloat = 0.5
  }
  
  required init(delegate: MainViewDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupUI()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateCities(_ cities: [CityModel]) {
    self.cities = cities
    filteredCities = cities
    tableView.reloadData()
  }
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = "Search by city name"
    searchBar.isTranslucent = false
    return searchBar
  }()
}


//MARK: - Private Zone
private extension MainView {
  
  func setupUI() {
    
    backgroundColor = .white
    //    searchBar.returnKeyType = UIReturnKeyType.done
    //    searchBar.delegate = self
    //    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
    //
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
    pressureLabel = UILabel(text: "998 hpa", font: font, textAlignment: .center, textColor: .black)
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
      print("Today");
    case 1:
      print("Next days")
    default:
      break
    }
  }
  
  func setupTableView() {
    tableView = UITableView()
    tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
    tableView.dataSource = self
  }
  
  func filterCityByName(typedWord: String, myCities: [CityModel]) -> [CityModel] {
    return myCities.filter { $0.name.contains(typedWord) }
  }
}


// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    filteredCities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
    let city = filteredCities[indexPath.row]
    
//    cell.updateUI(by: city)
    
    return cell
  }
}


//MARK: - UISearchBarDelegate
extension MainView: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let filterResult = filterCityByName(typedWord: searchText, myCities: cities)
    filteredCities = filterResult
    tableView.reloadData()
  }
}


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
      descriptionImageView.heightAnchor.constraint(equalToConstant: 25),
      descriptionImageView.widthAnchor.constraint(equalToConstant: 25),
      
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
      
      tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      
    ])
  }
}