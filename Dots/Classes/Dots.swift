//
//  Dots.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ComplitionHandler = (Data?, URLResponse?, Error?) -> Void

public class Dots {
  public static let main = Dots()
  private var concurrentQueue = OperationQueue()
  
  private var maxConcurrentOperation: Int {
    let networkStatus = Reachability().connectionStatus()
    switch networkStatus {
    case .Unknown, .Offline:
      return 0
    case .Online(.WWAN):
      return 2
    case .Online(.WiFi):
      return 6
    }
  }
  
  public init () {
    concurrentQueue.maxConcurrentOperationCount = maxConcurrentOperation
  }
  
  public func request(
    _ url: URL,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil,
    complitionHandler: ComplitionHandler?) {
    
    concurrentQueue.addOperation(DataLoadOperationS(url, method: method, parameters: parameters, headers: headers, complitionHandler: complitionHandler))
    
  }
}
