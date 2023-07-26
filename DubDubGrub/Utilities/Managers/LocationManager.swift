//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 19/07/23.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
