//
//  WeatherForecastUITests.swift
//  WeatherForecastUITests
//
//  Created by Ana Popilian on 19/05/2021.
//  Copyright © 2021 Ana. All rights reserved.
//

import XCTest

final class WeatherForecastUITests: XCTestCase {
   
   private var app: XCUIApplication!
   
   override func setUp() {
      super.setUp()
      
      continueAfterFailure = false
      app = XCUIApplication()
      app.launch()
   }
   
   func testTodayWeatherElements() {
      wait(forElement: app.cityNameLabel, timeout: 4)
      wait(forElement: app.temperatureLabel, timeout: 4)
      wait(forElement: app.descriptionImageView, timeout: 4)
      wait(forElement: app.weatherDescriptionLabel, timeout: 4)
      wait(forElement: app.humidityLabel, timeout: 4)
      wait(forElement: app.windLabel, timeout: 4)
      wait(forElement: app.pressureLabel, timeout: 4)
      wait(forElement: app.sunriseLabel, timeout: 4)
      wait(forElement: app.sunsetLabel, timeout: 4)
   }
   
   func testTodayTableViewElements() {
      wait(forElement: app.todayHourLabel, timeout: 4)
      wait(forElement: app.todayTemperatureCellLabel, timeout: 4)
      wait(forElement: app.todayCellWeatherImage, timeout: 4)
   }
   
   func testNextDaysTableViewElements() {
      app.segmentControl.buttons["Next days"].tap()
      wait(forElement: app.dateLabel, timeout: 4)
   }
   
   func testNextDaysCollectionViewElements() {
      app.segmentControl.buttons["Next days"].tap()
      wait(forElement: app.nextDaysHourLabel, timeout: 5)
      wait(forElement: app.nextDaysTemperatureLabel, timeout: 5)
   }
   
   func testVerticalScrolling() {
      app.segmentedControls.buttons["Next days"].tap()
      let firstCells = app.nextDaysTableView.cells.matching(identifier: "next-days-table-view-cell").count
      app.nextDaysTableView.swipeUp()
      let allCells = firstCells + app.nextDaysTableView.cells.matching(identifier: "next-days-table-view-cell").count
      XCTAssertNotEqual(firstCells, allCells)
   }
   
   func testHorizontalScrolling() {
      app.segmentedControls.buttons["Next days"].tap()
      let firstCells = app.nextDaysTableView.cells.matching(identifier: "next-days-table-view-cell").count
      app.nextDaysTableView.swipeLeft()
      let allCells = firstCells + app.nextDaysTableView.cells.matching(identifier: "next-days-table-view-cell").count
      XCTAssertNotEqual(firstCells, allCells)
   }
}


// MARK: - XCUIApplication extension
private extension XCUIApplication {
   
   var activityIndicator: XCUIElement { self.activityIndicators["activity-indicator"]}
   var cityNameLabel: XCUIElement { self.staticTexts["city-label"] }
   var temperatureLabel: XCUIElement { self.staticTexts["todayTemperature-label"] }
   var descriptionImageView: XCUIElement { self.images["description-image"]}
   var weatherDescriptionLabel: XCUIElement { self.staticTexts["weather-description"]}
   var humidityLabel: XCUIElement { self.staticTexts["humidity-label"]}
   var windLabel: XCUIElement { self.staticTexts["wind-label"]}
   var pressureLabel: XCUIElement { self.staticTexts["pressure-label"]}
   var sunriseLabel: XCUIElement { self.staticTexts["sunrise-label"]}
   var sunsetLabel: XCUIElement { self.staticTexts["sunset-label"]}
   
   var todayHourLabel: XCUIElement { self.tables.cells.staticTexts["hour-label"] }
   var todayTemperatureCellLabel: XCUIElement { self.tables.cells.staticTexts["temperature-label"] }
   var todayCellWeatherImage: XCUIElement { self.tables.cells.images["cell-image"] }
   
   var segmentControl: XCUIElement { self.segmentedControls["segment-control"] }
   
   var nextDaysTableView: XCUIElement { self.tables["next-days-table-view"] }
   var dateLabel: XCUIElement { self.tables.staticTexts["date-label"] }
   
   var nextDaysHourLabel: XCUIElement { self.staticTexts["nextDays-hour"] }
   var nextDaysTemperatureLabel: XCUIElement { self.staticTexts["nextDays-temperature"] }
}
