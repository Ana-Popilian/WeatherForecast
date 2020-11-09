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
        static let cellWidth: CGFloat = 90
        static let cellHeight: CGFloat = 90
        static let padding: CGFloat = 10
    }
    
    override func prepare() {
        super.prepare()
        
        self.itemSize = CGSize(width: ViewTrait.cellWidth, height: ViewTrait.cellHeight)
        self.sectionInset = UIEdgeInsets(top: 0, left: ViewTrait.padding, bottom: 0, right: ViewTrait.padding)
        self.scrollDirection = .horizontal
    }
}
