//
//  LocationManager.swift
//  weather
//
//  Created by David Rozmajzl on 7/22/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    @Published private(set) var weather = Weather()
    private let locationManager = CLLocationManager()
    private let apiManager = APIManager()
    private(set) var locationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 3000
        // Location starts to updating with no limit. After the first location is fetched,
        // I change the distance filter to 3000 so that from here on out, the location will
        // be updated once the user moves 3 kilometers from their original point
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func updateWeatherInfo() {
        if let lat = lastLocation?.coordinate.latitude, let lon = lastLocation?.coordinate.longitude {
            apiManager.getWeather(latitude: lat, longitude: lon) { weather in
                self.weather = weather
            }
        }
    }
    
    var lastLocation: CLLocation? {
        willSet {
            if let lat = lastLocation?.coordinate.latitude, let lon = lastLocation?.coordinate.longitude {
                apiManager.getWeather(latitude: lat, longitude: lon) { weather in
                    self.weather = weather
                }
            }
        }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.lastLocation = location
    }
}
