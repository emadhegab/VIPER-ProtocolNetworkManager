//
//  Environment.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Emad Abdalla Hegab on 31.01.18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation

/// Environment is a struct which encapsulate all the informations
/// we need to perform a setup of our Networking Layer.
/// In this example we just define the name of the environment (ie. Production,
/// Test Environment #1 and so on) and the base url to complete requests.
/// You may also want to include any SSL certificate or wethever you need.
public struct Environment {

    /// Base URL of the environment with default value
    public var host: String? =  Bundle.main.apiBaseURL

    /// This is the list of common headers which will be part of each Request
    /// Some headers value maybe overwritten by Request's own headers
    public var headers: [String: Any]?

    /// Cache policy
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

}

/// The dispatcher is responsible to execute a Request
/// by calling the underlyning layer (maybe URLSession, Alamofire
/// or just a fake dispatcher which return mocked results).
/// As output for a Request it should provide a Response.
public protocol Dispatcher {

    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: Environment)

    /// This function execute the request and provide a Promise
    /// with the response.
    ///
    /// - Parameter request: request to execute
    /// - Returns: promise
    func execute(request: Request, completion: @escaping (Response) -> Void) throws

}
