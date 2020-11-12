//
//  NextDaysForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by Ana on 28/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//

import UIKit

final class NextDaysForecastTableViewCell: UITableViewCell, Identifiable {
    
    private var dateLabel: UILabel!
    private var collectionView: UICollectionView!
    private var nextDaysWeatherData: [Detail]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(by forecastData: [Detail]) {
        nextDaysWeatherData = forecastData
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        dateLabel.text = forecastData.first?.date.asLongerString()
    }
}


// MARK: - Private Zone
private extension NextDaysForecastTableViewCell {
    
    func setupUI() {
        setupDateLabel()
        setupCollectionView()
        
        addSubViews()
        setupConstraints()
    }
    
    func setupDateLabel() {
        let font = UIFont.systemFont(ofSize: 14)
        dateLabel = UILabel(font: font, textAlignment: .center, textColor: .black)
    }
    
    func setupCollectionView() {
        let layout = HourForecastViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NextDaysForecastCollectionViewCell.self, forCellWithReuseIdentifier: NextDaysForecastCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDataSource
extension NextDaysForecastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nextDaysWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextDaysForecastCollectionViewCell.identifier, for: indexPath) as! NextDaysForecastCollectionViewCell
        
        let hourForecast = nextDaysWeatherData[indexPath.row]
        cell.bindCell(by: hourForecast)
        return cell
    }
}


// MARK: - Constraints Zone
private extension NextDaysForecastTableViewCell {
    
    func addSubViews() {
        self.contentView.addSubviewWC(dateLabel)
        self.contentView.addSubviewWC(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
