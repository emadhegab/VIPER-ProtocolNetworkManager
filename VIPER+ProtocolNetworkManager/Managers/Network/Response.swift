//
//  Response.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Emad Abdalla Hegab on 31.01.18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum Response {

    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error?)

    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        let statusCode = response.r?.statusCode
        guard let urlResponse = response.r else {
            self = .error(500, response.error)
            return
        }

        if let error = response.error {
            self = .error(urlResponse.statusCode, error)
            return
        }

        guard statusCode == 200, response.error == nil else {
            self = .error(urlResponse.statusCode, response.error)
            return
        }

        guard let data = response.data else {
            self = .error(urlResponse.statusCode, response.error)
            return
        }

        switch request.dataType {
        case .data:
            self = .data(data)
        case .json:
            do {
                self = try .json(JSON(data: data))
            } catch {
                print("\(error.localizedDescription)")
                self = .error(500, error)
            }
        }
    }
}
