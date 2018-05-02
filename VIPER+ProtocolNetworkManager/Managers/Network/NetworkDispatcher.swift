//
//  NetworkDispatcher.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Emad Abdalla Hegab on 31.01.18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation

public class NetworkDispatcher: Dispatcher {
    typealias StringDict = [String: Any]
    private var environment: Environment
    private var defaultHeader: StringDict!
    private var session: URLSession

    required public init(environment: Environment) {
        self.environment = environment
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }

    public func execute(request: Request, completion: @escaping (Response) -> Void) throws {

        guard let rq = try self.prepareURLRequest(for: request) else { return }
        let dataTask = self.session.dataTask(with: rq, completionHandler: { (data, urlResponse, error) in
            let response = Response( (urlResponse as? HTTPURLResponse, data, error), for: request)
            completion(response)
        })
        dataTask.resume()
    }

    private func prepareURLRequest(for request: Request) throws -> URLRequest? {
        // Compose the url
        let fullUrl = "\(environment.host!)/\(request.path)"
        var urlRequest: URLRequest!

        // Working with parameters
        switch request.parameters {
        case .body(let params):
            // Parameters are part of the body
            if let url = URL(string: fullUrl) {
                urlRequest = URLRequest(url: url)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params!, options: .init(rawValue: 0))
                createHeadersInRequest(&urlRequest, request)
            }
        case .url(let params):
            // Parameters are part of the url

            let queryParams = params?.map({ (element) -> URLQueryItem in
                return URLQueryItem(name: element.key, value: element.value as? String)
            })
            guard var components = URLComponents(string: fullUrl), let url = URL(string: fullUrl) else {
                throw NetworkError.serverError
            }
            components.queryItems = queryParams
            urlRequest = URLRequest(url: url)
            urlRequest.url = components.url
            createHeadersInRequest(&urlRequest, request)
        }
        return urlRequest
    }

    fileprivate func createHeadersInRequest(_ urlRequest: inout URLRequest!, _ request: Request) {
        // Add headers from enviornment and request
        setupDefaultHeaders().forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        environment.headers?.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        // Setup HTTP method
        urlRequest.httpMethod = request.method.rawValue
    }

    private func setupDefaultHeaders() -> StringDict {
        return ["Accept": "application/json"]
    }
}

enum NetworkError: Error {
    case serverError
}
