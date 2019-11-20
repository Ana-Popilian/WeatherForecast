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
    static let minColumnWidth: CGFloat = 130
    static let cellHeight: CGFloat = 140
  }
  
  override func prepare() {
    super.prepare()
    
    guard let collectionView = collectionView else { return }
    
    let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
    let maxNumColumns = availableWidth / ViewTrait.minColumnWidth
    let cellWidth = (availableWidth / maxNumColumns).rounded(.down)
    
    self.itemSize = CGSize(width: cellWidth, height: ViewTrait.cellHeight)
    self.sectionInsetReference = .fromSafeArea
  }
}
