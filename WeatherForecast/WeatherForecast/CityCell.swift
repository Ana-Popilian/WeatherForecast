//
//  CityCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
  
  let idLabel: UILabel = {
    let label = UILabel()
    label.text = "id "
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let coordLabel: UILabel = {
    let label = UILabel()
    label.text = "coordonates "
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "city name "
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let countryLabel: UILabel = {
    let label = UILabel()
    label.text = "country name "
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupLayout() {
    
    addSubview(idLabel)
    addSubview(coordLabel)
    addSubview(nameLabel)
    addSubview(countryLabel)
    
    NSLayoutConstraint.activate([
      
      idLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      idLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      idLabel.widthAnchor.constraint(equalTo: coordLabel.widthAnchor),
      
      coordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      coordLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 10),
      coordLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
      nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      nameLabel.widthAnchor.constraint(equalTo: countryLabel.widthAnchor),
      
      countryLabel.topAnchor.constraint(equalTo: coordLabel.bottomAnchor, constant: 5),
      countryLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
      countryLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      countryLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
    ])
  }
  
  func getCoordinateFormatted(_ city: City) -> String {
    return "lat: \(city.coord.lat) lon: \(city.coord.lon)"
  }
}

