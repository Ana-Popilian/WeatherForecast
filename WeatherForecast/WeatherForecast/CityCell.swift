//
//  CityCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
  
  let cityIdLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let coordonatesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let cityNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let countryNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupLayout() {
    
    addSubview(cityIdLabel)
    addSubview(coordonatesLabel)
    addSubview(cityNameLabel)
    addSubview(countryNameLabel)
    
    NSLayoutConstraint.activate([
      cityIdLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
      cityIdLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      cityIdLabel.widthAnchor.constraint(equalTo: coordonatesLabel.widthAnchor),
      
      coordonatesLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
      coordonatesLabel.leadingAnchor.constraint(equalTo: cityIdLabel.trailingAnchor, constant: 5),
      coordonatesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      cityNameLabel.topAnchor.constraint(equalTo: cityIdLabel.bottomAnchor, constant: 5),
      cityNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      cityNameLabel.widthAnchor.constraint(equalTo: countryNameLabel.widthAnchor),
      
      countryNameLabel.topAnchor.constraint(equalTo: coordonatesLabel.bottomAnchor, constant: 5),
      countryNameLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 5),
      countryNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      countryNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
    ])
  }
  
  func getCoordinateFormatted(_ city: City) -> String {
    return "lat: \(city.coord.lat) lon: \(city.coord.lon)"
  }
}

