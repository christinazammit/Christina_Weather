//
//  WeatherModel.swift
//  Christina_Weather
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation

public class WeatherModel: ObservableObject {
    @Published var name: String = ""
    @Published var country: String = ""
    @Published var temp_c: String = ""
    @Published var feelslike_c: String = ""
    @Published var wind_kph: String = ""
    @Published var wind_dir: String = ""
    @Published var humidity: String = ""
    @Published var uv: String = ""
    @Published var vis_km: String = ""
    
    public let locationHelper: LocationHelper
    
    public init(locationHelper: LocationHelper) {
        self.locationHelper = locationHelper
    }
    
    public func refresh() {
        locationHelper.loadData { weather in
            DispatchQueue.main.async {
                self.name = weather.name
                self.country = weather.country
                self.temp_c = "\(weather.temp_c)ºC"
                self.feelslike_c = "Feels like \(weather.feelslike_c)ºC"
                self.wind_kph = "Wind: \(weather.wind_kph) kph"
                self.wind_dir = "Wind direction: \(weather.wind_dir)"
                self.humidity = "Humidity: \(weather.humidity)"
                self.uv = "UV: \(weather.uv)"
                self.vis_km = "Visibility: \(weather.vis_km) km"
            }
        }
    }
}
