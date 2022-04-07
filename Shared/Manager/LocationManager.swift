//
//  LocationManager.swift
//  HowMuchTokyoDome (iOS)
//
//  Created by tomoyo_kageyama on 2022/03/30.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    
    // The first location reported by the CLLocationManager.
    @Published var initialUserCoordinate: CLLocationCoordinate2D?
    // The latest location reported by the CLLocationManager.
    @Published var currentUserCoordinate: CLLocationCoordinate2D?

    override private init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.activityType = .other
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestAuthorization() {
         if locationManager.authorizationStatus == .notDetermined {
             locationManager.requestWhenInUseAuthorization()
         }
     }

     func startTracking() {
         locationManager.startUpdatingLocation()
     }

     func stopTracking() {
         locationManager.stopUpdatingLocation()
     }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            NSLog("Location authorization status changed to '\(status == .authorizedAlways ? "authorizedAlways" : "authorizedWhenInUse")'")
        case .denied, .restricted:
            NSLog("Location authorization status changed to '\(status == .denied ? "denied" : "restricted")'")
            stopTracking()
        case .notDetermined:
            NSLog("Location authorization status changed to 'notDetermined'")
        default:
            NSLog("Location authorization status changed to unknown status '\(status)'")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // We are only interested in the user's most recent location.
        guard let location = locations.last else { return }
        // Use the location to update the location manager's published state.
        let coordinate = location.coordinate
        if initialUserCoordinate == nil {
            initialUserCoordinate = coordinate
        }
        currentUserCoordinate = coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Location manager failed with error: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        authorizationSubject.send(manager.authorizationStatus)
    }
}
