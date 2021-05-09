//
//  WeatherApiType.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 09/05/2021.
//

import Foundation

enum WeatherApiType {
    
    case current
    case forecast(Int)
    
    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast/daily"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .current:
            return []
        case .forecast(let daysNumber):
            return [URLQueryItem(name: "cnt", value: String(daysNumber))]
        }
    }
    
}
