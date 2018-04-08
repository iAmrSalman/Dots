//
//  UIImageExtension.swift
//  Dots-iOS
//
//  Created by Amr Salman on 8/4/18.
//  Copyright © 2018 Dots. All rights reserved.
//

import UIKit

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

