//
//  HourForecastViewLayout.swift
//  WeatherForecast
//
//  Created by Ana on 31/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class HourForecastViewLayout: UICollectionViewFlowLayout {
  
  private enum ViewTrait {
    static let cellWidth: CGFloat = UIScreen.main.bounds.width
    static let cellHeight: CGFloat = UIScreen.main.bounds.width * 0.30
    static let verticalPadding: CGFloat = 10
  }
  
  override func prepare() {
    super.prepare()
    
    self.itemSize = CGSize(width: ViewTrait.cellWidth, height: ViewTrait.cellHeight)
    self.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
  }
}
