//
//  WeatherModel.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation

public class WeatherModel: ObservableObject {
    @Published var city: String = ""
    @Published var country: String = ""
    @Published var temp: String = ""
    @Published var feelsLike: String = ""
    @Published var wind: String = ""
    @Published var windDir: String = ""
    @Published var humidity: String = ""
    @Published var uv: String = ""
    @Published var vis: String = ""
    
    public let locationHelper: LocationHelper
    
    public init(locationHelper: LocationHelper) {
        self.locationHelper = locationHelper
    }
    
    public func refresh() {
        locationHelper.loadData { weather in
            DispatchQueue.main.async {
                self.city = weather.city
                self.country = weather.country
                self.temp = "\(weather.temp)ºC"
                self.feelsLike = "Feels like \(weather.feelsLike)ºC"
                self.wind = "Wind: \(weather.wind) kph"
                self.windDir = "Wind direction: \(weather.windDir)"
                self.humidity = "Humidity: \(weather.humidity)"
                self.uv = "UV: \(weather.uv)"
                self.vis = "Visibility: \(weather.visibility) km"
            }
        }
    }
}
