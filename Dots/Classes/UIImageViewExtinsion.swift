//
//  UIImageViewExtinsion.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public extension UIImageView {
  func setImage(withURL url: URL) {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    indicator.center = self.center
    self.addSubview(indicator)
    indicator.startAnimating()
    Dots.main.request(url) { (data: Data?, response: URLResponse?, error: Error?) in
      if error == nil {
        guard let data = data else { return }
        self.image = UIImage(data: data)
        indicator.removeFromSuperview()
      }
    }
  }
}
