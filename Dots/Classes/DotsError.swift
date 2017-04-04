//
//  DotsError.swift
//  Pods
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

enum DotsError: Error {
  public enum ParameterEncodingFailureReason {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case propertyListEncodingFailed(error: Error)
  }
  
  case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
  
}
