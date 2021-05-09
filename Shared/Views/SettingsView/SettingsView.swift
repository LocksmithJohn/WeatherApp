//
//  SettingsView.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 09/05/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Text(viewModel.infoText ?? "-")
                .padding()
                .accentColor(.red)
            TextField("City:", text: $viewModel.cityName)
                .font(.title)
                .padding()
            TextField("DaysNumber:", text: $viewModel.daysNumber)
                .keyboardType(.numberPad)
                .padding()
                .font(.title)
            Button("Ok") {
                viewModel.saveChanges()
            }
        }
    }
    
}
