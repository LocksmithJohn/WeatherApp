//
//  CurrentWeatherViewModel.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation

final class CurrentWeatherViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeatherDTO?
    
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
        guard let cityName = params.cityName else {
            return
        }
        
        cancellable = weatherNetworkService
            .fetchCurrentWeather(phrase: cityName)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] weatherModel in
                self?.currentWeather = CurrentWeatherDTO(weatherModel)
            }
    }
    
}
