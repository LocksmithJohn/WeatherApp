//
//  CurrentWeatherView.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import Foundation
import SwiftUI

struct CurrentWeatherView: View {

    @ObservedObject var viewModel: CurrentWeatherViewModel

    var body: some View {
        VStack {
            Text(viewModel.currentWeather?.locationName ?? "")
                .padding()
                .font(.title)
            Text(String(viewModel.currentWeather?.currentTemperature ?? 0))
            Text(String(viewModel.currentWeather?.minTemperature ?? 0))
            Text(String(viewModel.currentWeather?.maxTemperature ?? 0))
        }
    }

}
