//
//  LocationParameter.swift
//  LocationMap
//
//  Created by tomoyo_kageyama on 2022/03/24.
//

import CoreLocation

class LocationParameter : ObservableObject {
    @Published var locationManager = CLLocationManager()
}
