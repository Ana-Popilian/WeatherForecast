//
//  UIImageView+Download.swift
//  WeatherForecast
//
//  Created by Ana on 15/10/2020.
//  Copyright © 2020 Ana. All rights reserved.
//


import UIKit

extension UIImageView {
  
  func downloadImage( name: String, downloadFinishedHandler: (() -> Void)? = nil) {
    
    let networkManager = ParserService()
    networkManager.fetchImage(imageName: name, completion: { data in
      guard let data = data else {
        DispatchQueue.main.async {
          downloadFinishedHandler?()
        }
        return
      }
      
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        self.image = image
        downloadFinishedHandler?()
      }
    })
  }
}
