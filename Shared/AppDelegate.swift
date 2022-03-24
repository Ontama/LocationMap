//
//  AppDelegate.swift
//  LocationMap
//
//  Created by tomoyo_kageyama on 2022/03/24.
//

import SwiftUI
import CoreLocation

class AppDelegate: UIResponder, UIApplicationDelegate {
    @ObservedObject var param = LocationParameter()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        param.locationManager.delegate = self
        
        param.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            param.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            param.locationManager.distanceFilter = 10
            param.locationManager.activityType = .fitness
            param.locationManager.startUpdatingLocation()
        }
        
        return true
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }
        
        let location = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        
        print("緯度: ", location.latitude, "経度: ", location.longitude)
    }
}
