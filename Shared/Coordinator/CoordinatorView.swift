//
//  CoordinatorView.swift
//  iOSWeatherApp
//
//  Created by Jan Ślusarz on 08/05/2021.
//

import SwiftUI

struct CoordinatorView: View {
    
    @ObservedObject var coordinator: Coordinator
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button(action: { coordinator.openSheet() } ) {
                        Image(systemName: "gear")
                            .padding(.trailing, 30)
                            .padding([.top,.bottom], 8)
                    }
                }
                TabView {
                    coordinator.toCurrentWeatherScreen()
                        .tabItem {
                            Image(systemName: "cloud.sun")
                            Text("Weather")
                        }
                    coordinator.toDailyForecastScreen()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Forecast")
                        }
                }
                .sheet(isPresented: $coordinator.sheetPresented,
                       content: { coordinator.routeToSettingsScreen() })
        }
    }
    
}
