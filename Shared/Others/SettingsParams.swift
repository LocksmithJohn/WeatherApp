//
//  SettingsParams.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Foundation

final class SettingsParams: ObservableObject {
    
    @Published var cityName: String
    @Published var daysNumber: Int
    
    init() {
        cityName = GlobalConstants.defaultCity
        daysNumber = GlobalConstants.defaultDaysNumber
    }
    
}
