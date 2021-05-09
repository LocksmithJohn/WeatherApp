//
//  SettingsViewModel.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 09/05/2021.
//

import Combine
import Foundation

final class SettingsViewModel: ObservableObject, Identifiable {
    
    private enum Constants {
        static let oopsText = "oops... something went wrong."
        static let doneText = "done."
    }
    
    @Published var params: SettingsParams
    @Published var infoText: String?
    @Published var cityName: String = "" { didSet {
        params.cityName = cityName
    }}
    @Published var daysNumber: String = "" { didSet {
        params.daysNumber = Int(daysNumber) ?? GlobalConstants.defaultDaysNumber
    }}
    
    private let weatherNetworkService: WeatherNetworkServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    init(params: SettingsParams,
         weatherNetworkService: WeatherNetworkServiceProtocol) {
        self.params = params
        self.weatherNetworkService = weatherNetworkService
        bindParamsChange()
        bindInfoText()
    }

    func saveChanges() {
        weatherNetworkService.fetchCurrentWeather(phrase: params.cityName)
        weatherNetworkService.fetchDailyForecast(phrase: params.cityName,
                                                 daysNumber: params.daysNumber)
    }

}

private extension SettingsViewModel {
    
    func bindParamsChange() {
        params.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &subscriptions)
    }
    
    func bindInfoText() {
        weatherNetworkService.currentWeatherPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.infoText = Constants.oopsText
            }, receiveValue: { [weak self] value in
                self?.infoText = value == nil ? Constants.oopsText : Constants.doneText
            })
            .store(in: &subscriptions)
    }
    
}
