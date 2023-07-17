//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 12/07/23.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.573840, longitude: 68.795335), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region).ignoresSafeArea()
            
            VStack {
                LogoView().shadow(radius: 10)
                Spacer()
            }
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
