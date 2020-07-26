//
//  MapView.swift
//  weather
//
//  Created by David Rozmajzl on 7/23/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        //uiView.isUserInteractionEnabled = false
        uiView.setRegion(region, animated: true)
    }
}
