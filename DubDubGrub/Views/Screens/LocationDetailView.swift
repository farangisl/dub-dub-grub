//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 13/07/23.
//

import SwiftUI

struct LocationDetailView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var location: DDGLocation
    
    var body: some View {
        VStack {
            BannerImageView(imageName: "default-banner-asset")
            
            AddressView(address: location.address)
            
            DescriptionView(text: location.description)
            
            ZStack {
                    Capsule()
                    .frame(height: 80)
                    .padding()
                    .foregroundColor(Color(.secondarySystemBackground))
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        OptionButton(image: "location.fill")
                    }
                    
                    Link(destination: URL(string: location.websiteURL)!, label: {
                        OptionButton(image: "network")
                    })
                    
                    Button {
                        
                    } label: {
                        OptionButton(image: "phone.fill")
                    }
                    
                    Button {
                        
                    } label: {
                        OptionButton(image: "person.fill.xmark", color: .pink)
                    }
                }
            }
            
            Text("Who's Here?")
                .font(.title2)
                .bold()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1..<10) { item in
                        FirstNameAvatarView(firstName: "Avatar")
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width - 40)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Text("Dismiss")
                        .foregroundColor(.brandPrimary)
                }
                
                ToolbarItem(placement: .principal) {
                    Text(location.name)
                        .fontWeight(.semibold)
                }
            }
        }
        .offset(y: -45)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationDetailView(location: DDGLocation(record: MockData.location))
        }
    }
}

struct OptionButton: View {
    
    var image: String = ""
    var color = Color.brandPrimary
    
    var body: some View {
            Image(systemName: image)
                .imageScale(.large)
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(color)
                .clipShape(Circle())
    }
}

struct FirstNameAvatarView: View {
    
    var firstName: String
    
    var body: some View {
        VStack {
            AvatarView(size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {
    
    var address: String
    
    var body: some View {
        Label(address, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(Color(.systemGray))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .padding(.horizontal)
    }
}
