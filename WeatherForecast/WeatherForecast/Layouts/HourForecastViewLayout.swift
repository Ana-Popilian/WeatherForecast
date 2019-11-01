//
//  HourForecastViewLayout.swift
//  WeatherForecast
//
//  Created by Ana on 31/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

class HourForecastViewLayout: UICollectionViewFlowLayout {
  
  private let minColumnWidth: CGFloat = 100
  private let cellHeight: CGFloat = 140
  
  override func prepare() {
      super.prepare()

      guard let collectionView = collectionView else { return }
      
      let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
      let maxNumColumns = Int(availableWidth / minColumnWidth)
      let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
      
      self.itemSize = CGSize(width: cellWidth, height: cellHeight)
//      self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
      self.sectionInsetReference = .fromSafeArea
  }
}
