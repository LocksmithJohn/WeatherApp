//
//  CurrentWeatherViewModel.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Combine
import Foundation
import SwiftUI

final class CurrentWeatherViewModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeatherDTO?
    @Published var isLoading: Bool = false
    
    private let weatherNetworkService: WeatherNetworkServiceProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(weatherNetworkService: WeatherNetworkServiceProtocol) {
        self.weatherNetworkService = weatherNetworkService
        fetchData()
    }
    
}

private extension CurrentWeatherViewModel {
    
    func fetchData() {
        isLoading = true
        weatherNetworkService
            .currentWeatherPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] weatherModel in
                self?.isLoading = false
                guard let weatherModel = weatherModel else {
                    return
                }
                
                self?.currentWeather = CurrentWeatherDTO(weatherModel)
            }
            .store(in: &subscriptions)
    }
    
}
