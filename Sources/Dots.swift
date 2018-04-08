//
//  Dots.swift
//  Dots
//
//  Created by Amr Salman on 8/4/18.
//  Copyright © 2018 Dots. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias ComplitionHandler = (Dot) -> Void

public class Dots {
    public static let defualt = Dots()
    private var concurrentQueue = OperationQueue()
    
    private var maxConcurrentOperation: Int {
        #if os(watchOS)
        return 2
        #else
        let networkStatus = Reachability().connectionStatus()
        switch networkStatus {
        case .Unknown, .Offline:
            return 0
        case .Online(.WWAN):
            return 2
        case .Online(.WiFi):
            return 6
        }
        #endif
    }
    
    public init () {
        concurrentQueue.maxConcurrentOperationCount = self.maxConcurrentOperation
    }
    
    public init(maxConcurrentRequests: Int) {
        concurrentQueue.maxConcurrentOperationCount = maxConcurrentOperation
    }
    
    //TODO:- enable session configration
    /*
     public init(sessionConfigration: URLSessionConfiguration) {
     
     }
     */
    
    public func request(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = .url,
        headers: HTTPHeaders? = nil,
        concurrency: Concurrency = .async,
        qualityOfService: QualityOfService = .default,
        complitionHandler: ComplitionHandler? = nil) {
        
        if maxConcurrentOperation == 0 {
            if let complitionHandler = complitionHandler {
                complitionHandler(Dot(data: nil, response: nil, error: DotsError.offline))
            }
            return
        }
        
        switch concurrency {
        case .sync:
            concurrentQueue.addOperation(DataLoadOperationSync(URL(string: url), method: method, parameters: parameters, encoding: encoding, headers: headers, qualityOfService: qualityOfService, complitionHandler: complitionHandler))
        default:
            concurrentQueue.addOperation(DataLoadOperationAsync(URL(string: url), method: method, parameters: parameters, encoding: encoding, headers: headers, qualityOfService: qualityOfService, complitionHandler: complitionHandler))
        }
        
    }
}
