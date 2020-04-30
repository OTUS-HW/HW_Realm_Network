//
//  BaseURL.swift
//  HW_Realm_Network
//
//  Created by Rustam on 07.03.2020.
//  Copyright © 2020 Rustam. All rights reserved.
//

import Foundation

struct Base_URL {
    var urlComponents = URLComponents()
    let scheme = "http"
    let host   = "api.openweathermap.org/data/2.5"
    let path   = "forecast"
    let queryParams: [String: String] = ["dataFormat": "json"]
    mutating func urlConfigList () -> URL {
        urlComponents.scheme = self.scheme
        urlComponents.host   = self.host
        urlComponents.path   = self.path
        urlComponents.setQueryItems(with: queryParams)
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        return url
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
