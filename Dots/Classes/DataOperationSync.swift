//
//  DataOperationS.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

internal class DataLoadOperationSync: Operation, DataLoadProtocol {
  internal var url: URL?
  internal var complitionHandler: ComplitionHandler?
  internal var method: HTTPMethod
  internal var parameters: Parameters?
  internal var headers: HTTPHeaders?
  
  init(
    _ url: URL?,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil,
    qualityOfService: QualityOfService = .default,
    complitionHandler: ComplitionHandler? = nil ) {
    self.url = url
    self.method = method
    self.parameters = parameters
    self.headers = headers
    self.complitionHandler = complitionHandler
    super.init()
    self.qualityOfService = qualityOfService
  }
  
  override func main() {
    guard let url = url else { return }
    guard let session = createSession(configuration: .defualt) else { return }
    
    var originalRequest = URLRequest(url: url)
    originalRequest.httpMethod = method.rawValue
    originalRequest.allHTTPHeaderFields = headers
    
    do {
      let encodedURLRequest = try encode(&originalRequest, with: parameters)
      session.dataTask(with: encodedURLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
        DispatchQueue.main.async {
          guard let complitionHandler = self.complitionHandler else { return }
          complitionHandler(Dot(data: data, response: response, error: error))
        }
      }).resume()
    } catch {
      guard let complitionHandler = self.complitionHandler else { return }
      complitionHandler(Dot(data: nil, response: nil, error: error))
    }
    
    
  }
  
}
