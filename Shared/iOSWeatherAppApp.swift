//
//  iOSWeatherAppApp.swift
//  Shared
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import SwiftUI

@main
struct iOSWeatherAppApp: App {
    
    private let weatherNetworkService = WeatherNetworkService()
    private let settingsParams = SettingsParams()

    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: .init(weatherNetworkService: weatherNetworkService,
                                               settingsParams: settingsParams))
        }
    }
    
}
