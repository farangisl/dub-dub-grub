//
//  DubDubGrubApp.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 12/07/23.
//

import SwiftUI

@main
struct DubDubGrubApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(locationManager)
        }
    }
}
