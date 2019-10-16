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
  func didSelectedCity(_ city: City)
}

class MainView: UIView {
  
  
  private let cellId = "cellId"
  weak var delegate : MainViewDelegate?
  
  var filteredCities = [City]()
  var isSearching = false
  private var cities = [City]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    setupLayout()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    searchBar.delegate = self
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateCities(_ cities: [City]) {
    self.cities = cities
    filteredCities = cities
    
    tableView.reloadData()
  }
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = " Search by city name"
    searchBar.isTranslucent = false
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    
    return searchBar
  }()
  
  private let mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.backgroundColor = .white
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()
  
  func setupLayout() {
    self.addSubview(searchBar)
    self.addSubview(tableView)
    self.addSubview(mapView)
    
    NSLayoutConstraint.activate([
      
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      mapView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
      mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func filterCityByName(typedWord: String, myCities: [City]) -> [City] {
    var filteredArray = [City]()
    for city in myCities {
      if city.name.contains(typedWord) {
        filteredArray.append(city)
      }
    }
    return filteredArray
  }
   
  func showLocationOnMapByRow(_ row: Int) {
    let selectedCity = filteredCities[row]
       let location = CLLocationCoordinate2D(latitude: selectedCity.coord.lat, longitude: selectedCity.coord.lon)
       
       let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
       let region = MKCoordinateRegion(center: location, span: span)
       mapView.setRegion(region, animated: true)
  }
  
}

extension MainView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredCities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CityCell
    if cell == nil {
      cell = CityCell()
    }
    cell?.setupLayout()
    
    let city = filteredCities[indexPath.row]
    cell?.nameLabel.text = city.name
    cell?.coordLabel.text = cell?.getCoordinateFormatted(city)
    cell?.idLabel.text = String(city.id)
    cell?.countryLabel.text = city.country
    
    return cell!
  }
  
}

extension MainView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    searchBar.resignFirstResponder()
    showLocationOnMapByRow(indexPath.row)
    
    let selectedCity = filteredCities[indexPath.row]
    
    delegate?.didSelectedCity(selectedCity)
   
  }
}

extension MainView: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let filterResult = filterCityByName(typedWord: searchText, myCities: cities)
    filteredCities = filterResult
    tableView.reloadData()
  }
}


