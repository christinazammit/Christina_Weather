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

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var address : String = "unknown"
    @Published var currentLocation: CLLocation?
    
    private let locationManager = CLLocationManager()
    private var lastSeenLocation: CLLocation?
    private let geocoder = CLGeocoder()
    
    private let API_KEY = "4d99584f6c78448687210616210211"
    private var completionHandler: (() -> Void)?
    
    override init() {
        super.init()
        
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && ( self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
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
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Authorization Status : \(manager.authorizationStatus.rawValue)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastSeenLocation = locations.first
        print(#function, "last seen location: \(self.lastSeenLocation!)")
        
        if locations.last != nil{
            self.currentLocation = locations.last!
        }else{
            self.currentLocation = locations.first
        }
        print(#function, "current location: \(self.currentLocation!)")
        self.doReverseGeocoding(location: self.currentLocation!, completionHandler: {_,_ in })
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "error: \(error.localizedDescription)")
    }
    
    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping(String?, NSError?) -> Void){
        var result  = ""
        
        self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if error != nil{
                //                Unable to get address for given coordinates
                completionHandler(nil, error as NSError?)
            }else{
                if let placemarkList = placemarks, let placemark = placemarkList.first{
                    result = CNPostalAddressFormatter.string(from: placemark.postalAddress!, style: .mailingAddress)
                    self.address = result
                    print(#function, "address : \(result)")
                    
                    completionHandler(result, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }
}

struct WeatherAPI: Decodable {
    let temp: Double
    let wind: Double
    let windDir: String
    let humidity: Int
    let feelsLike: Double
    let vis: Double
    let uv: Double
}

struct APIResponse {
    let name: String
    let current: WeatherAPI
}
