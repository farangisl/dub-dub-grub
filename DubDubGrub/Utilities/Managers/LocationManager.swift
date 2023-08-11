//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 19/07/23.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
    var selectedLocation: DDGLocation?
}
