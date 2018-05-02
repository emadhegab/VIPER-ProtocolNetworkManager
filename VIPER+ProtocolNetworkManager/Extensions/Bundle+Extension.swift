//
//  Bundle+Extension.swift
//  VIPER+ProtocolNetworkManager
//
//  Created by Mohamed Hegab on 5/2/18.
//  Copyright © 2018 Mohamed Emad Hegab. All rights reserved.
//

import Foundation

extension Bundle {
    var apiBaseURL: String {
        return  Bundle.main.object(forInfoDictionaryKey: "BASE_URL_ENDPOINT") as? String ?? ""
    }
}
