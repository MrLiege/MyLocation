//
//  LocationManager.swift
//  MyLocation
//
//  Created by Artyom Petrichenko on 25.07.2024.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationManagerDelegate: AnyObject {
    func manager(didUpdate location: CLLocation)
    func manager(didFailWithError error: Error)
    func manager(didFailWithLocationError error: LocationError)
}

final class LocationManager: NSObject {
    
    private var manager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    var lastKnownLocation: CLLocation?
    
    override init() {
        super.init()
        
        requestAuth()
        setupManager()
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    private func setupManager() {
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        
        manager.activityType = .other
    }
    
    private func requestAuth() {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorized:
            break
        case .notDetermined, .restricted, .denied:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sortedLocations = locations.sorted { $0.horizontalAccuracy < $1.horizontalAccuracy }
        guard let bestLocation = sortedLocations.first else { return }
        lastKnownLocation = bestLocation
        delegate?.manager(didUpdate: bestLocation)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                delegate?.manager(didFailWithLocationError: .locationUnknown)
            case .denied:
                delegate?.manager(didFailWithLocationError: .locationServicesDisabled)
            default:
                delegate?.manager(didFailWithError: error)
            }
        } else {
            delegate?.manager(didFailWithError: error)
        }
    }
}
