//
//  CurrentWeatherDTO.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

struct CurrentWeatherDTO {
    
    let locationName: String
    let currentTemperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    
    init(_ inputModel: CurrentWeatherModel) {
        self.locationName = inputModel.name
        self.currentTemperature = inputModel.main.temp
        self.maxTemperature = inputModel.main.tempMax
        self.minTemperature = inputModel.main.tempMin
    }

}
