//
//  AppTabViewModel.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 31/07/23.
//

import SwiftUI

extension AppTabView {
    
    final class AppTabViewModel: ObservableObject {
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet { isShowingOnboardView = hasSeenOnboardView }
        }
        
        let kHasSeenOnboardView = "hasSeenOnboardView"
        
        
        func checkIfHasSeenOnboard() {
            if !hasSeenOnboardView {
                hasSeenOnboardView = true
            }
        }
    }
}
