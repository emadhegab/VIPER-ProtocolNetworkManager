//
//  QuoteTask.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuoteTask <T: Codable>: Operation {

    var request: Request {
        return QuoteRequest.getRandomQuote
    }

    func exeute(in dispatcher: Dispatcher, completed: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {

        do {
            try dispatcher.execute(request: self.request, completion: { (response) in
                switch response {
                case .data(let data):
                    do {
                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//                        uncomment this in case you have some json properties in Snake Case and you just want to decode it to camel Case... workes only for swift 4.1

                        let object = try decoder.decode(T.self, from: data)
                        completed(object)
                    } catch {
                        onError(error)
                    }
                    break
                case .error(_, let networkError):
                    guard let error = networkError else { break }
                    onError(error)
                    break
                default: break

                }
            })
        } catch {
            onError(error)
        }
    }
}
