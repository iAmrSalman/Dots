//
//  ConcurrentOperation.swift
//  Dots
//
//  Created by Amr Salman on 4/4/17.
//
//

import Foundation

internal class ConcurrentOperation: Operation {
  enum State: String {
    case ready, executing, finished
    
    fileprivate var keyPath: String {
      return "is" + rawValue
    }
  }
  
  var state = State.ready {
    willSet {
      willChangeValue(forKey: newValue.keyPath)
      willChangeValue(forKey: state.keyPath)
    }
    didSet {
      didChangeValue(forKey: oldValue.keyPath)
      didChangeValue(forKey: state.keyPath)
    }
  }
}

extension ConcurrentOperation {
  override var isReady: Bool {
    return super.isReady && state == .ready
  }
  
  override var isExecuting: Bool {
    return state == .executing
  }
  
  override var isFinished: Bool {
    return state == .finished
  }
  
  override var isAsynchronous: Bool {
    return true
  }
  
  override func start() {
    if isCancelled {
      state = .finished
      return
    }
    
    state = .executing
    main()
  }
  
  override func cancel() {
    state = .finished
  }
  
}
