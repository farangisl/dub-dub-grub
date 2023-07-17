//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 12/07/23.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { item in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationListCell()
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
