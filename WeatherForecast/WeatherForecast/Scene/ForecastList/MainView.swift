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
  private var filteredCities = [CityModel]()
  private var cities = [CityModel]()
  
  private enum ViewTrait {
    static let heightMultiplier: CGFloat = 0.5
  }
  
  required init(delegate: MainViewDelegate?) {
    super.init(frame: .zero)
    self.delegate = delegate
    
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateCities(_ cities: [CityModel]) {
    self.cities = cities
    filteredCities = cities
    tableView.reloadData()
  }
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
    return tableView
  }()
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = "Search by city name"
    searchBar.isTranslucent = false
    return searchBar
  }()
  
  private let mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.backgroundColor = .white
    return mapView
  }()
}


//MARK: - Private Zone
private extension MainView {
  
  func setupLayout() {
    
    backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    searchBar.delegate = self
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
    
    addSubviews()
    setupConstraints()
  }
  
  func filterCityByName(typedWord: String, myCities: [CityModel]) -> [CityModel] {
    return myCities.filter { $0.name.contains(typedWord) }
  }
  
  func showLocationOnMap(byRow row: Int) {
    let selectedCity = filteredCities[row]
    let location = CLLocationCoordinate2D(latitude: selectedCity.coord.lat, longitude: selectedCity.coord.lon)
    
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
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
    
    cell.updateUI(by: city)

    return cell
  }
}


//MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    searchBar.resignFirstResponder()
    showLocationOnMap(byRow: indexPath.row)
    let selectedCity = filteredCities[indexPath.row]
    delegate?.didSelectedCity(selectedCity)
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
    addSubviewWithoutConstraints(searchBar)
    addSubviewWithoutConstraints(tableView)
    addSubviewWithoutConstraints(mapView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: ViewTrait.heightMultiplier),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      mapView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
      mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
