//
//  WeatherNetworkService.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation

protocol WeatherNetworkServiceProtocol {
    
    var currentWeatherPublisher: AnyPublisher<CurrentWeatherModel?, Error> { get }
    var dailyForecastPublisher: AnyPublisher<DailyForecastModel, Error> { get }
    
    func fetchCurrentWeather(phrase: String)
    func fetchDailyForecast(phrase: String, daysNumber: Int)
    
}

final class WeatherNetworkService: WeatherNetworkServiceProtocol, NetworkService {
    
    private enum Constants {
        
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let appid = URLQueryItem(name: "appid", value: "698840dc5cdb54502fdf559957ce6d86")
        
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let currentWeatherSubject = PassthroughSubject<CurrentWeatherModel?, Error>()
    var currentWeatherPublisher: AnyPublisher<CurrentWeatherModel?, Error> {
        currentWeatherSubject.eraseToAnyPublisher()
    }
    
    private let dailyForecastSubject = PassthroughSubject<DailyForecastModel, Error>()
    var dailyForecastPublisher: AnyPublisher<DailyForecastModel, Error> {
        dailyForecastSubject.eraseToAnyPublisher()
    }
    
    init() {
        fetchDailyForecast(phrase: GlobalConstants.defaultCity,
                           daysNumber: GlobalConstants.defaultDaysNumber)
        fetchCurrentWeather(phrase: GlobalConstants.defaultCity)
    }
    
    func fetchCurrentWeather(phrase: String) {
        guard let url = produceComponents(.current, phrase: phrase).url else {
            return
        }
        
        request(request: URLRequest(url: url))
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.currentWeatherSubject.send(nil)
                }
            } receiveValue: { [weak self] dataModel in
                self?.currentWeatherSubject.send(dataModel)
            }
            .store(in: &subscriptions)
    }
    
    func fetchDailyForecast(phrase: String, daysNumber: Int) {
        guard let url = produceComponents(.forecast(daysNumber), phrase: phrase).url else {
            return
        }
        
        request(request: URLRequest(url: url))
            .sink { _ in // tutaj komentarz
            } receiveValue: { [weak self] dataModel in
                self?.dailyForecastSubject.send(dataModel)
            }
            .store(in: &subscriptions)
    }
    
}

private extension WeatherNetworkService {
    
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
