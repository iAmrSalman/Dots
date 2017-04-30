//
//  ViewController.swift
//  Dots
//
//  Created by Amr Salman on 04/04/2017.
//  Copyright (c) 2017 Amr Salman. All rights reserved.
//

import UIKit
import Dots

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    loadImage()
    loadText()
  }
  
  func loadImage() {
    imageView.setImage(withURL: "https://secret-ocean-30920.herokuapp.com/img.JPG")
  }
  
  func loadText() {
    
    Dots.defualt.request("https://secret-ocean-30920.herokuapp.com/amr.json") { (dot: Dot) in
      guard let json = dot.json else {
        self.textView.text = "nothing"
        return
      }
      var str = "{\n"
      for (key, value) in json {
        str += "\(key): \(value),\n"
      }
      str += "}"
      
      self.textView.text = str
    }
        
  }
  
}
