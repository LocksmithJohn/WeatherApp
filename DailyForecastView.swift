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
                    Text(String(day.temperatureDay))
                    Text(String(day.temperatureNight))
                }
            }
        }
    }
}
