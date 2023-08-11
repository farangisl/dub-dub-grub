//
//  AppTabView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 12/07/23.
//

import SwiftUI


struct AppTabView: View {
    
    @StateObject private var viewModel = AppTabViewModel()

    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            
            LocationListView()
                .tabItem { Label("Locations", systemImage: "building") }
            
            NavigationStack { ProfileView() }
                .tabItem { Label("Profile", systemImage: "person") }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .task {
            try? await CloudKitManager.shared.getUserRecord()
            viewModel.checkIfHasSeenOnboard()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView) {
            OnboardingView()
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
