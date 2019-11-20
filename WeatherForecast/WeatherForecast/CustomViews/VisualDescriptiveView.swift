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
  
  private enum ViewTrait {
    static let defaultPadding: CGFloat = 10
    static let defaultVerticalSpacing: CGFloat = 3
  }
  
  init(image: UIImage, title: String) {
    super.init(frame: .zero)
    setupImageView(image)
    setupTitleLabel(title)
    
    addSubviews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateTitle(_ title: String) {
    titleLabel.text = title
  }
}


//MARK: - Private Zone
private extension VisualDescriptiveView {
  
  func setupImageView(_ image: UIImage) {
    imageView = UIImageView(image: image)
  }
  
  func setupTitleLabel(_ title: String) {
    titleLabel = UILabel()
    titleLabel.numberOfLines = 2
    titleLabel.text = title
    titleLabel.font = UIFont.systemFont(ofSize: 13)
    titleLabel.textAlignment = .center
    titleLabel.textColor = .white
  }
}


//MARK: - Constraints Zone
private extension VisualDescriptiveView {
  
  func addSubviews() {
    addSubviewWithoutConstraints(imageView)
    addSubviewWithoutConstraints(titleLabel)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTrait.defaultPadding),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTrait.defaultPadding),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTrait.defaultPadding),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ViewTrait.defaultVerticalSpacing),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
