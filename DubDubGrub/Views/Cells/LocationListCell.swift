//
//  LocationListCell.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 13/07/23.
//

import SwiftUI

struct LocationListCell: View {
    var body: some View {
        HStack {
            Image("default-square-asset")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text("Test Location Name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    ForEach(1..<6) { i in
                        AvatarView(size: 35)
                    }
                }
            }
            .padding(.leading)
            
        }
    }
}

struct LocationListCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationListCell()
    }
}
