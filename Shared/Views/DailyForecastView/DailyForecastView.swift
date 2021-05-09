//
//  DailyForecastView.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import SwiftUI

struct DailyForecastView: View {
    
    @ObservedObject var viewModel: DailyForecastViewModel

    var body: some View {
        List {
            ForEach(viewModel.dailyForecastDTO.days) { day in
                HStack {
                    // oczywiscie danych mozna wyswietlic znacznie więcej
                    // potraktowalem to raczej jako przyklad
                    Text(String(day.name))
                    Spacer()
                    Text(String(day.temperatureDay))
                    Text(String(day.temperatureNight))
                }
            }
        }
    }
    
}
