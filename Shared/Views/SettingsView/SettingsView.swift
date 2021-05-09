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
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .padding()
            TextField("DaysNumber:", text: $viewModel.daysNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
                .font(.title)
            Button(action : { viewModel.saveChanges() }) {
                HStack {
                    Text("Ok")
                }.frame(width: 300, height: 50, alignment: .center)
            }
        }
    }
    
}
