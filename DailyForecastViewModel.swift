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
    
    private let weatherNetworkService: WeatherNetworkService
    private let params: SettingsParams
    
    private var cancellable: AnyCancellable?
    
    init(weatherNetworkService: WeatherNetworkService,
         params: SettingsParams) {
        self.weatherNetworkService = weatherNetworkService
        self.params = params
        
        bindData()
    }
    
    private func bindData() {
        guard let cityName = params.cityName,
              let daysNumber = params.daysNumber else {
            return
        }
        
        cancellable = weatherNetworkService
            .fetchDailyForecast(phrase: cityName, daysNumber: daysNumber)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] forecastModel in
                self?.dailyForecastDTO = DailyForecastDTO(forecastModel)
            }
    }
    
}
