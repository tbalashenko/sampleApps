//
//  LocationManager.swift
//  newMTB
//
//  Created by Татьяна Балашенко on 12.05.21.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func updateLocation(location: CLLocation)
}

final class LocationManager: CLLocationManager, ObservableObject {
    static let shared = LocationManager()
    
    var locationManagerDelegate: LocationManagerDelegate?
    
    private override init() {
        super.init()
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
        self.delegate = self
    }
}

//MARK - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        locationManagerDelegate?.updateLocation(location: location)
    }
}

