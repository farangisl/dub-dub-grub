//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 19/07/23.
//

import MapKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.573840, longitude: 68.795335), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @Published var locations: [DDGLocation] = []

    func getLocations() {
        CloudKitManager.getLocations { [self] result in
            switch result {
                
            case .success(let locations):
                self.locations = locations
            case .failure(_):
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }
    
}
