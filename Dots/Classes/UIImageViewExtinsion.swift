//
//  UIImageViewExtinsion.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public extension UIImageView {
  func setImage(withURL url: String) {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    indicator.center = self.center
    self.addSubview(indicator)
    indicator.startAnimating()
    Dots.defualt.request(url) { (dot: Dot) in
      if dot.error == nil {
        guard let data = dot.data else { return }
        self.image = UIImage(data: data)
        indicator.removeFromSuperview()
      }
    }
  }
}
