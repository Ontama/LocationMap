//
//  MapView.swift
//  LocationMap
//
//  Created by tomoyo_kageyama on 2022/03/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region = MKCoordinateRegion() // 座標領域
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @ObservedObject var viewModel: MapViewModel
    private let span = MKCoordinateSpan(latitudeDelta: 0.0009, longitudeDelta: 0.0009)
    
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: [
                PinItem(coordinate: .init(latitude: viewModel.latitude, longitude: viewModel.longitude))
            ],
            annotationContent: { item in
            MapMarker(coordinate: item.coordinate)
        })
            .onAppear(perform: {
                viewModel.startTracking()
            })
            .onReceive(viewModel.currentChangePublisher(), perform: { locations in
                updateReigion(coordinate: CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude))
            })
        // 現在地を取得したら現在地を中心にする
            .onReceive(viewModel.$location) { locations in
                updateReigion(coordinate: CLLocationCoordinate2D(latitude: locations.coordinate.latitude, longitude: locations.coordinate.longitude))
            }
    }
    
    // 引数で取得した緯度経度を使って動的に表示領域の中心位置と、縮尺を決める
    func updateReigion(coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate,
                                    span: span
        )
    }
}
