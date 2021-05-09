//
//  DailyForecastViewModel.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation

final class DailyForecastViewModel: ObservableObject {
    
    @Published var dailyForecastDTO = DailyForecastDTO()
    @Published var isLoading: Bool = false
    
    private let weatherNetworkService: WeatherNetworkServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(weatherNetworkService: WeatherNetworkServiceProtocol) {
        self.weatherNetworkService = weatherNetworkService
        bindData()
    }
    
}

private extension DailyForecastViewModel {
    
    func bindData() {
        isLoading = true
        weatherNetworkService
            .dailyForecastPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] forecastModel in
                self?.isLoading = false
                self?.dailyForecastDTO = DailyForecastDTO(forecastModel)
            }
            .store(in: &subscriptions)
    }
    
}
