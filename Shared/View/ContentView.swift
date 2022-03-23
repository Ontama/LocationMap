//
//  ContentView.swift
//  Shared
//
//  Created by tomoyo_kageyama on 2022/03/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MapViewModel
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button("request") {
                    viewModel.requestAuthorization()
                }
                Button("start") {
                    viewModel.startTracking()
                    viewModel.changeCurrentLocation()
                }
                Button("stop") {
                    viewModel.stopTracking()
                }
                Button("現在地") {
                    viewModel.changeCurrentLocation()
                }
            }
            Text(viewModel.authorizationStatus.description)
            Text(String(format: "longitude: %f", viewModel.longitude))
            Text(String(format: "latitude: %f", viewModel.latitude))
            MapView(viewModel: viewModel)
        }.onAppear {
            viewModel.activate()
        }.onDisappear {
            viewModel.deactivate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:  MapViewModel(model: LocationDataSource()))
    }
}
