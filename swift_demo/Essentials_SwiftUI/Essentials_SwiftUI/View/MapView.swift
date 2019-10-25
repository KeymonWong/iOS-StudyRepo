//
//  MapView.swift
//  Landmark
//
//  Created by keymon on 2019/10/23.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coor: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ map: MKMapView, context: Context) {
//        let coor = CLLocationCoordinate2D(latitude: 34.0122, longitude: -116.1668)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coor, span: span)
        
        map.setRegion(region, animated: true)
        map.showsScale = true
        map.showsTraffic = true
        map.showsUserLocation = true
        map.showsCompass = true
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coor: landmarkData[0].locationCoor)
    }
}
