//
//  DataOperationS.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

internal class DataLoadOperationS: Operation {
  private var url: URL?
  private var complitionHandler: ComplitionHandler?
  private var method: HTTPMethod
  private var parameters: Parameters?
  private var headers: HTTPHeaders?
  
  init(
    _ url: URL?,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    headers: HTTPHeaders? = nil,
    complitionHandler: ComplitionHandler? = nil ) {
    self.url = url
    self.method = method
    self.parameters = parameters
    self.headers = headers
    self.complitionHandler = complitionHandler
    super.init()
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
          complitionHandler(data, response, error)
        }
      }).resume()
    } catch {
      guard let complitionHandler = self.complitionHandler else { return }
      complitionHandler(nil, nil, error)
    }
    
    
  }
  
  public func encode( _ urlRequest: inout URLRequest, with parameters: Parameters?) throws -> URLRequest {
    
    guard let parameters = parameters else { return urlRequest }
    
    if HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET") != nil {
      guard let url = urlRequest.url else {
        throw DotsError.parameterEncodingFailed(reason: .missingURL)
      }
      
      if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
        let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
        urlComponents.percentEncodedQuery = percentEncodedQuery
        urlRequest.url = urlComponents.url
      }
    } else {
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
      }
      
      urlRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
    }
    
    return urlRequest
  }
  
  public func escape(_ string: String) -> String {
    let generalDelimitersToEncode = ":#[]@"
    let subDelimitersToEncode = "!$&'()*+,;="
    
    var allowedCharacterSet = CharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    
    var escaped = ""
    
    escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    
    return escaped
  }
  
  public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []
    
    if let dictionary = value as? [String: Any] {
      for (nestedKey, value) in dictionary {
        components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
      }
    } else if let array = value as? [Any] {
      for value in array {
        components += queryComponents(fromKey: "\(key)[]", value: value)
      }
    } else if let bool = value as? Bool {
      components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
      components.append((escape(key), escape("\(value)")))
    }
    
    return components
  }
  
  private func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    
    for key in parameters.keys.sorted(by: <) {
      let value = parameters[key]!
      components += queryComponents(fromKey: key, value: value)
    }
    
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
  }
  
  
  private func configuringCach() -> URLCache? {
    guard let cachesDiroctoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
    let cacheURL = cachesDiroctoryURL.appendingPathComponent(url!.absoluteString)
    var diskPath = cacheURL.path
    
    #if os(macOS)
      diskPath = cacheURL.absoluteString
    #endif
    
    let cache = URLCache(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: diskPath)
    
    return cache
  }
  
  private func createSession(configuration: DotsSessionConfiguration) -> URLSession? {
    let sessionConfiguration: URLSessionConfiguration!
    switch configuration {
    case .defualt:
      sessionConfiguration = URLSessionConfiguration.default
      
      guard let cache = configuringCach() else { return nil }
      sessionConfiguration.urlCache = cache
      sessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
    case .ephemeral:
      sessionConfiguration = URLSessionConfiguration.ephemeral
    case .background:
      sessionConfiguration = URLSessionConfiguration.background(withIdentifier: url!.absoluteString)
    }
    
    let session = URLSession(configuration: sessionConfiguration)
    
    return session
    
  }
}
