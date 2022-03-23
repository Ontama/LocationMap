//
//  PinItem.swift
//  LocationMap
//
//  Created by tomoyo_kageyama on 2022/03/22.
//

import CoreLocation
import Foundation

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
