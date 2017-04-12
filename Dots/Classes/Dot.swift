//
//  Result.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public struct Dot {
  public var data: Data?
  public var response: URLResponse?
  public var error: Error?
  public var json: [String: Any]? {
    do {
      guard let data = data else { return nil }
      guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else { return nil }
      return json
    } catch {
      return nil
    }
  }
}
