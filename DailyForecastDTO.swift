//
//  DailyForecastDTO.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Foundation

struct DailyForecastDTO {
    
    var days = [Day]()

    init(_ inputModel: DailyForecastModel? = nil) {
        guard let model = inputModel else {
            return
        }
        
        self.days = model.list
            .map {
                Day(temperatureDay: $0.temp.day,
                    temperatureNight: $0.temp.night)
            }
    }
    
    struct Day: Identifiable {
        
        let id = UUID()
        let temperatureDay: Double
        let temperatureNight: Double
        
    }

}
