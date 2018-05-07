//
//  QuoteRequest.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation

enum QuoteRequest: Request {
    case getRandomQuote

    var path: String {
        return "quotes/random/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRandomQuote:
            return .get
        }
    }
    
    var parameters: RequestParams {
        return .url(nil)
    }
    
    var headers: [String : Any]? {
        return ["Authorization": "xyz"]
    }
    
    var dataType: DataType {
        return .data
    }
    
    
}
