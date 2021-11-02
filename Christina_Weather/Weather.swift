//
//  Weather.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation

public struct Weather {
    let name: String
    let country: String
    let temp_c: String
    let feelslike_c: String
    let wind_kph: String
    let wind_dir: String
    let humidity: String
    let uv: String
    let vis_km: String
    
    init(response: APIResponse) {
        name = response.location.name
        country = response.location.country
        temp_c = "\(Int(response.current.temp_c))"
        feelslike_c = "\(Int(response.current.feelslike_c))"
        wind_kph = "\(Int(response.current.wind_kph))"
        wind_dir = response.current.wind_dir
        humidity = "\(Int(response.current.humidity))"
        uv = "\(Int(response.current.uv))"
        vis_km = "\(Int(response.current.vis_km))"
    }
}
