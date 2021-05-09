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
    
    @State private var loaderVisible = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
            } else {
                VStack {
                    Text(viewModel.currentWeather?.locationName ?? "-")
                        .padding()
                        .font(.system(size: 50))
                    Text(viewModel.currentWeather?.currentTemperature ?? "-")
                        .font(.system(size: 50))
                    Text(viewModel.currentWeather?.description ?? "-")
                        .font(.title)
                    VStack(alignment: .trailing) {
                        Text(viewModel.currentWeather?.minTemperature ?? "-")
                        Text(viewModel.currentWeather?.maxTemperature ?? "-")
                    }.padding()
                }
            }
        }
    }
    
}
