//
//  WeatherNetworkService.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation

final class WeatherNetworkService: NetworkService {
    
    private enum Constants {
        
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let appid = URLQueryItem(name: "appid", value: "698840dc5cdb54502fdf559957ce6d86")
        
    }
    
    func fetchCurrentWeather(phrase: String) -> AnyPublisher<CurrentWeatherModel, Error> {
        guard let url = produceComponents(.current, phrase: phrase).url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return request(request: URLRequest(url: url))
    }
    
    func fetchDailyForecast(phrase: String, daysNumber: Int) -> AnyPublisher<DailyForecastModel, Error> {
        guard let url = produceComponents(.forecast(daysNumber), phrase: phrase).url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return request(request: URLRequest(url: url))
    }

    func produceComponents(_ type: WeatherApiType, phrase: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = type.path
        components.queryItems =
            [searchTerm(phrase: phrase)] +
            type.queryItems +
            [Constants.appid]

        return components
    }
    
    func searchTerm(phrase: String) -> URLQueryItem {
        URLQueryItem(name: "q", value: phrase)
    }
    
}

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


