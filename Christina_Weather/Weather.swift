//
//  Weather.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation

public struct Weather {
    let city: String
    let country: String
    let temp: String
    let feelsLike: String
    let wind: String
    let windDir: String
    let humidity: String
    let uv: String
    let visibility: String
    
    init(response: WeatherAPI) {
        city = response.name
        country = response.country
        temp = "\(Int(response.temp))"
        feelsLike = "\(Int(response.feelsLike))"
        wind = "\(Int(response.wind))"
        windDir = response.windDir
        humidity = "\(Int(response.humidity))"
        uv = "\(Int(response.uv))"
        visibility = "\(Int(response.vis))"
    }
}
