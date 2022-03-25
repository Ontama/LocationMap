//
//  LocationMapApp.swift
//  Shared
//
//  Created by tomoyo_kageyama on 2022/03/22.
//

import SwiftUI
import CoreLocation

@main
struct LocationMapApp: App {
    @StateObject var viewModel = MapViewModel(model: LocationDataSource())
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
