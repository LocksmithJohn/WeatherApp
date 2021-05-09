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
        
        model.list.enumerated().forEach {
            self.days.append(
                Day(name: dayNames(numberOf: model.list.count)[$0.offset],
                    temperatureDay: "day: " + String($0.element.temp.day.fromKelvinToCelsius()) + "º",
                    temperatureNight: "night: " + String($0.element.temp.night.fromKelvinToCelsius()) + "º")
            )
        }
    }
    
    struct Day: Identifiable {
        
        let id = UUID()
        let name: String
        let temperatureDay: String
        let temperatureNight: String
        
    }

}

private extension DailyForecastDTO {
    
    func dayNames(numberOf: Int) -> [String] {
        var names = [String]()
        
        var nextDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        var dateComponent = DateComponents()
        dateComponent.day = 1
        
        for _ in 0 ..< numberOf {
            nextDate = Calendar.current.date(byAdding: dateComponent, to: nextDate) ?? Date()
            names.append(dateFormatter.string(from: nextDate))
        }
        
        return names
    }
    
}
