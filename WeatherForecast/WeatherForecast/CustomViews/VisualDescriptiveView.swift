//
//  VisualDescriptiveView.swift
//  WeatherForecast
//
//  Created by Ana on 23/10/2019.
//  Copyright © 2019 Ana. All rights reserved.
//

import UIKit

final class VisualDescriptiveView: UIView {
  
  private var imageView: UIImageView!
  private var titleLabel: UILabel!
  
  init(image: UIImage, title: String) {
    super.init(frame: .zero)
    setupImageView(image)
    setupTitleLabel(title)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateTitle(_ title: String) {
    titleLabel.text = title
  }
}

private extension VisualDescriptiveView {
  
  func setupImageView(_ image: UIImage) {
     imageView = UIImageView(image: image)
     imageView.translatesAutoresizingMaskIntoConstraints = false
     
     self.addSubview(imageView)

     NSLayoutConstraint.activate([
       imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
       imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
       imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
       imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
     ])
   }
   
  func setupTitleLabel(_ title: String) {
     titleLabel = UILabel()
     titleLabel.numberOfLines = 2
     titleLabel.text = title
     titleLabel.font = UIFont.systemFont(ofSize: 13)
     titleLabel.textAlignment = .center
     titleLabel.textColor = .white
     titleLabel.translatesAutoresizingMaskIntoConstraints = false
     
     self.addSubview(titleLabel)
     
     NSLayoutConstraint.activate([
       titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
       titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
       titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
       titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
     ])
   }
}
