//
//  Coordinator.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Foundation

final class Coordinator: ObservableObject {
    
    // Zaproponowany koordynator składa się z dwóch części: Coordinator i CoordinatorView,
    // uznałem, że w przypadku SwiftUI, tak to właśnie najlepiej zrobić
    // W celu tworzenia viewModeli przydałby się jakis dependency kontener,
    // ale z powodu czasu uprościłem to nieco i viewModele tworzone są tutaj
    
    @Published var sheetPresented = false
    
    private var currentWeatherViewModel: CurrentWeatherViewModel!
    private var dailyForecastViewModel: DailyForecastViewModel!
    private var settingsViewModel: SettingsViewModel!
    private let settingsParams: SettingsParams
    private let weatherNetworkService: WeatherNetworkServiceProtocol
    
    init(weatherNetworkService: WeatherNetworkServiceProtocol,
         settingsParams: SettingsParams) {
        self.weatherNetworkService = weatherNetworkService
        self.settingsParams = settingsParams
    }
    
    func openSheet() {
        sheetPresented = true
    }
    
}

// Routowanie zaproponowałem jako prostą kompozycję
// wraz ze wzrostem projektu możnaby ją dzielić na podgrupy funkcjonalne
// przeszlo mi przez mysl bardziej generyczne routowanie, oparte o wspólne protokoły
// i zwracające widoki w zależności od jakiegoś enuma, ale na tę chwilę zostawiam to tak

extension Coordinator: RouteToCurrentWeatherScreen,
                       RouteToDailyForecastScreen,
                       RouteToSettingsScreen {
    
    func toCurrentWeatherScreen() -> CurrentWeatherView {
        if currentWeatherViewModel == nil {
            currentWeatherViewModel = CurrentWeatherViewModel(weatherNetworkService: self.weatherNetworkService)
        }
        
        return CurrentWeatherView(viewModel: currentWeatherViewModel)
    }
    
    func toDailyForecastScreen() -> DailyForecastView {
        if dailyForecastViewModel == nil {
            dailyForecastViewModel = DailyForecastViewModel(weatherNetworkService: weatherNetworkService)
        }
        
        return DailyForecastView(viewModel: dailyForecastViewModel)
    }
    
    func routeToSettingsScreen() -> SettingsView {
        if settingsViewModel == nil {
            settingsViewModel = SettingsViewModel(
                params: settingsParams, weatherNetworkService: weatherNetworkService
            )
        }
        
        return SettingsView(viewModel: settingsViewModel)
    }
    
}

protocol RouteToCurrentWeatherScreen {
    
    func toCurrentWeatherScreen() -> CurrentWeatherView
    
}

protocol RouteToDailyForecastScreen {
    
    func toDailyForecastScreen() -> DailyForecastView
    
}

protocol RouteToSettingsScreen {
    
    func routeToSettingsScreen() -> SettingsView
    
}
