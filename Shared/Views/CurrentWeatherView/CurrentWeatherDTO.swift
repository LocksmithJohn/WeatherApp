//
//  CurrentWeatherDTO.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

struct CurrentWeatherDTO {
    
    let locationName: String
    let description: String
    let currentTemperature: String
    let maxTemperature: String
    let minTemperature: String
    
    init(_ inputModel: CurrentWeatherModel) {
        self.locationName = inputModel.name
        self.description = inputModel.weather.first?.weatherDescription ?? "..."
        self.currentTemperature = String(inputModel.main.temp.fromKelvinToCelsius()) + "º"
        self.maxTemperature = "to: " + String(inputModel.main.tempMax.fromKelvinToCelsius()) + "º"
        self.minTemperature = "from: " + String(inputModel.main.tempMin.fromKelvinToCelsius()) + "º"
    }

}
