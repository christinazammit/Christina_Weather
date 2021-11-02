//
//  LocationHelper.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation
import CoreLocation

public final class LocationHelper: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "4d99584f6c78448687210616210211"
    private var completionHandler: (() -> Void)?
}

struct APIResponse: Decodable {
    let location: APILocation
    let current: APICurrent
}

struct APILocation: Decodable {
    let name: String
    let country: String
}

struct APICurrent: Decodable {
    let temp_c: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Int
    let feelslike_c: Double
    let vis_km: Double
    let uv: Double
}
