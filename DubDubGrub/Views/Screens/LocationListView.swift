//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 12/07/23.
//

import SwiftUI

struct LocationListView: View {
    
    @State private var locatioins: [DDGLocation] = [DDGLocation(record: MockData.location)]
    var body: some View {
        NavigationStack {
            List {
                ForEach(locatioins, id: \.ckRecordID) { locatioin in
                    NavigationLink(destination: LocationDetailView(location: locatioin)) {
                        LocationListCell(location: locatioin)
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
