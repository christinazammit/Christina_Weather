//
//  LocationHelper.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import Foundation
import CoreLocation
import Contacts
import MapKit

public final class LocationHelper: NSObject {
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var address : String = "unknown"
    @Published var currentLocation: CLLocation?
    
    private let locationManager = CLLocationManager()
    private var lastSeenLocation: CLLocation?
    
    private let API_KEY = "4d99584f6c78448687210616210211"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
        
        self.checkPermission()
    }
    
    func requestPermission() {
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkPermission(){
        print(#function, "Checking for permission")
        switch self.locationManager.authorizationStatus {
        case .denied:
            self.requestPermission()
        case .notDetermined:
            self.requestPermission()
        case .restricted:
            self.requestPermission()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    public func loadData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=\(coordinates.latitude),\(coordinates.longitude)"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard error == nil,
                  let data = data
            else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("error: \(error.localizedDescription)")
    }
    
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
