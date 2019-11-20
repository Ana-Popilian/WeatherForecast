//
//  CityCell.swift
//  ForecastWeather
//
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell, Identifiable {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview()
    setupConstraints()
  }
  
  private enum ViewTrait {
    static let defaultPadding: CGFloat = 5
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var cityIdLabel: UILabel = getDefaultLabel()
  private lazy var coordonatesLabel: UILabel = getDefaultLabel()
  private lazy var cityNameLabel: UILabel = getDefaultLabel()
  private lazy var countryNameLabel: UILabel = getDefaultLabel()
  
  func updateUI(by city: CityModel) {
    
    cityNameLabel.text = city.name
    coordonatesLabel.text = getCoordinateFormatted(city)
    cityIdLabel.text = String(city.id)
    countryNameLabel.text = city.country
  }
}


//MARK: - Private Zone
private extension CityCell {
  
  func getDefaultLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textAlignment = .center
    return label
  }
  
  func getCoordinateFormatted(_ city: CityModel) -> String {
    return "lat: \(city.coord.lat) lon: \(city.coord.lon)"
  }
}


//MARK: - Constraints Zone
private extension CityCell {
  
  func addSubview() {
    addSubviewWithoutConstraints(cityIdLabel)
    addSubviewWithoutConstraints(coordonatesLabel)
    addSubviewWithoutConstraints(cityNameLabel)
    addSubviewWithoutConstraints(countryNameLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      cityIdLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultPadding),
      cityIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      cityIdLabel.widthAnchor.constraint(equalTo: coordonatesLabel.widthAnchor),
      
      coordonatesLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultPadding),
      coordonatesLabel.leadingAnchor.constraint(equalTo: cityIdLabel.trailingAnchor, constant: ViewTrait.defaultPadding),
      coordonatesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      cityNameLabel.topAnchor.constraint(equalTo: cityIdLabel.bottomAnchor, constant: ViewTrait.defaultPadding),
      cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      cityIdLabel.widthAnchor.constraint(equalTo: countryNameLabel.widthAnchor),
      cityNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultPadding),
      
      countryNameLabel.topAnchor.constraint(equalTo: coordonatesLabel.bottomAnchor, constant: ViewTrait.defaultPadding),
      countryNameLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: ViewTrait.defaultPadding),
      countryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countryNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewTrait.defaultPadding)
    ])
  }
}
