//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 12/07/23.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(value: location) {
                        LocationListCell(location: location, profiles: viewModel.checkedInProfiles[location.id, default: []])
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(Text(viewModel.createVoiceOverSummary(for: location)))
                    }
                    
//                    NavigationLink(destination: viewModel.createLocationDetailView(for: location, in: dynamicTypeSize)) {
//                        LocationListCell(location: location, profiles: viewModel.checkedInProfiles[location.id, default: []])
//                            .accessibilityElement(children: .ignore)
//                            .accessibilityLabel(Text(viewModel.createVoiceOverSummary(for: location)))
//                    }
                }
            }
            .navigationTitle("Grub Spots")
            .navigationDestination(for: DDGLocation.self, destination: { location in viewModel.createLocationDetailView(for: location, in: dynamicTypeSize)})
            .listStyle(.plain)
            .task { await viewModel.getCheckedInProfilesDictionary() }
            .refreshable { await viewModel.getCheckedInProfilesDictionary() }
            .alert(item: $viewModel.alertItem, content: { $0.alert })
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
