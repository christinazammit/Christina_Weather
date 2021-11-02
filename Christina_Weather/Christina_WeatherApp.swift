//
//  Christina_WeatherApp.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import SwiftUI

@main
struct Christina_WeatherApp: App {
    
    let locationHelper = LocationHelper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationHelper)
        }
    }
}
