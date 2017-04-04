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
    let url = URL(string: "https://secret-ocean-30920.herokuapp.com/img.JPG")
    
    imageView.setImage(withURL: url!)
  }
  
  func loadText() {
    let url = URL(string: "https://secret-ocean-30920.herokuapp.com/amr.json")
    
    Dots.main.request(url!) { (data: Data?, response: URLResponse?, error: Error?) in
      self.textView.text = self.JSONStringify(data: data)
    }
    
  }
  
  func JSONStringify(data: Data?) -> String {
    guard let data = data else {return "No Data"}
    let theJSONText = String(data: data, encoding: String.Encoding.ascii)
    return theJSONText!
  }
  
  
}
