//
//  Christina_WeatherApp.swift
//  Christina_Weather
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-11-01.
//

import SwiftUI

@main
struct Christina_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let locationHelper = LocationHelper()
            let viewModel = WeatherModel(locationHelper: locationHelper)
            ContentView(viewModel: viewModel)
               
        }
    }
}
