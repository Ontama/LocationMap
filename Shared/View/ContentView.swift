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
                }
                Button("stop") {
                    viewModel.stopTracking()
                }
                CurrentLocationCenterButton(action: {
                    viewModel.currentLocationCenterButtonTappedSubject.send()
                })
            }
//            Text(viewModel.authorizationStatus.description)
            Text(String(format: "longitude: %f", viewModel.longitude))
            Text(String(format: "latitude: %f", viewModel.latitude))
            MapView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel:  MapViewModel())
    }
}
