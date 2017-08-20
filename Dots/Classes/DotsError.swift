//
//  DotsError.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

public enum DotsError: Error {
  public enum ParameterEncodingFailureReason {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case propertyListEncodingFailed(error: Error)
  }
  
  case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
  case offline
}

extension DotsError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .offline:
      return "No Internet access"
    case .parameterEncodingFailed(let reason):
      return reason.localizedDescription
    }
  }
}

extension DotsError.ParameterEncodingFailureReason {
  var localizedDescription: String {
    switch self {
    case .missingURL:
      return "URL request to encode was missing a URL"
    case .jsonEncodingFailed(let error):
      return "JSON could not be encoded because of error:\n\(error.localizedDescription)"
    case .propertyListEncodingFailed(let error):
      return "PropertyList could not be encoded because of error:\n\(error.localizedDescription)"
    }
  }
}
