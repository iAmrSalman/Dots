//
//  DataLoadOperation.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

internal class DataLoadOperationAsync: ConcurrentOperation, DataLoadProtocol {
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
    guard let url = url else { self.state = .finished; return }
    guard let session = createSession(configuration: .defualt) else { self.state = .finished; return }
    
    var originalRequest = URLRequest(url: url)
    originalRequest.httpMethod = method.rawValue
    originalRequest.allHTTPHeaderFields = headers
    
    do {
      let encodedURLRequest = try encode(&originalRequest, with: parameters)
      session.dataTask(with: encodedURLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
        DispatchQueue.main.async {
          guard let complitionHandler = self.complitionHandler else { self.state = .finished; return }
          complitionHandler(Dot(data: data, response: response, error: error))
          self.state = .finished
        }
      }).resume()
    } catch {
      guard let complitionHandler = self.complitionHandler else { self.state = .finished; return }
      complitionHandler(Dot(data: nil, response: nil, error: error))
      self.state = .finished
    }
    
    
  }
  
}
