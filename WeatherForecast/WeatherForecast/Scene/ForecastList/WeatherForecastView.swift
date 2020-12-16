//
//  MainView.swift
//  WeatherForecast
//  Created by Ana on 16/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

protocol WeatherForecastViewProtocol where Self: UIView {
    func updateWeatherData(_ weather: WeatherModel)
}

final class WeatherForecastView: UIView, WeatherForecastViewProtocol {
    
    private var topView: TopWeatherView!
    private var segmentControl: UISegmentedControl!
    private var todayForecastTableView: UITableView!
    private var nextDaysForecastTableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    private var todayData: [Detail]!
    private var nextDaysData: [Detail]!
    private var weatherData: WeatherModel!
    private var groupedWeatherData: [[Detail]]!
    
    private enum ViewTrait {
        static let heightMultiplier: CGFloat = 0.4
        static let segmentHeight: CGFloat = 30
        static let horizontalSpacing: CGFloat = 15
        static let verticalSpacing: CGFloat = 20
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
        activityIndicator.stopAnimating()
        segmentControl.isHidden = false
        filterNextDaysWeatherData()
        nextDaysForecastTableView.reloadData()
        filterTodayWeatherData()
        todayForecastTableView.reloadData()
        topView.cityNameLabel.text = weather.city.name
        let temp = Int(weather.weatherList.first!.tempInfo.temp)
        topView.temperatureLabel.text = "\(temp)℃"
        groupWeatherData()
        
        guard let image = weather.weatherList.first?.weather.first?.icon else {
            return
        }
        topView.descriptionImageView.downloadImage(name: image, downloadFinishedHandler: {
        })
        
        topView.descriptionLabel.text = "\(weather.weatherList.first!.weather.first!.description)"
        topView.humidityLabel.attributedText = convertToAttributedString(title: "Humidity: ", value: "\(weather.weatherList.first!.tempInfo.humidity)%")
        topView.windLabel.attributedText = convertToAttributedString(title: "Wind Speed: ", value: "\(weather.weatherList.first!.wind.speed)m/s")
        topView.pressureLabel.attributedText = convertToAttributedString(title: "Pressure: ", value: "\(weather.weatherList.first!.tempInfo.pressure)hPA")
        topView.sunriseLabel.attributedText = convertToAttributedString(title: "Sunrise: ", value: "\(weather.city.sunrise.asString(style: .none))")
        topView.sunsetLabel.attributedText = convertToAttributedString(title: "Sunset: ", value: "\(weather.city.sunset.asString(style: .none))")
    }
    
    private func convertToAttributedString(title: String, value: String) -> NSMutableAttributedString {
        let titleAtt = NSMutableAttributedString(string: title)
        let valueAtt = NSMutableAttributedString(string: value)
        titleAtt.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorHelper.customBlue, range: NSRange(location: 0, length: title.count - 1))
        
        titleAtt.append(valueAtt)
        return titleAtt
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
        setupActivityIndicator()
        
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
        segmentControl.backgroundColor = ColorHelper.customBlue
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
        todayForecastTableView.backgroundColor = .white
        todayForecastTableView.separatorStyle = .none
        todayForecastTableView.dataSource = self
    }
    
    func setupNextDaysForecastTableView() {
        nextDaysForecastTableView = UITableView()
        nextDaysForecastTableView.register(NextDaysForecastTableViewCell.self, forCellReuseIdentifier: NextDaysForecastTableViewCell.identifier)
        nextDaysForecastTableView.backgroundColor = .white
        nextDaysForecastTableView.separatorStyle = .none
        nextDaysForecastTableView.rowHeight = 140
        nextDaysForecastTableView.dataSource = self
    }
    
    func setupActivityIndicator() {
        segmentControl.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = ColorHelper.customBlue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
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
    
    func filterNextDaysWeatherData() {
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
    
    func groupWeatherData()  {
        let calendar = Calendar.current
        let groupedForecast = Dictionary(grouping: nextDaysData, by: {
            calendar.ordinality(of: .day, in: .year, for: $0.date)!
        })
        
        let orderedKeys = groupedForecast.keys.sorted { $0 < $1 }
        
        var groupArrayOrdered = [[Detail]]()
        for key in orderedKeys {
            groupArrayOrdered.append(groupedForecast[key]!)
            groupedWeatherData = groupArrayOrdered
        }
    }
}


// MARK: - UITableViewDataSource
extension WeatherForecastView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (todayData != nil), nextDaysData != nil else {
            return 0
        }
        if tableView == todayForecastTableView {
            return todayData.count
        } else {
            return groupedWeatherData.count
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
            let data = groupedWeatherData[indexPath.row]
            cell.bindData(by: data)
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
        addSubviewWC(activityIndicator)
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
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
