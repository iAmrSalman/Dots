//
//  HTTPMethod.swift
//  Dots
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public enum HTTPMethod: String {
  case options = "OPTIONS"
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
  case trace   = "TRACE"
  case connect = "CONNECT"
}
