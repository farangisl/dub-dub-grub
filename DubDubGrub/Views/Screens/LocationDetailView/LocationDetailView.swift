//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 13/07/23.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                BannerImageView(image: viewModel.location.createBannerImage())
                
                AddressView(address: viewModel.location.address)
                
                DescriptionView(text: viewModel.location.description)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .padding()
                        .foregroundColor(Color(.secondarySystemBackground))
                    HStack(spacing: 20) {
                        Button {
                            viewModel.getDirectionsToLocation()
                        } label: {
                            OptionButton(image: "location.fill")
                        }
                        
                        Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                            OptionButton(image: "network")
                        })
                        
                        Button {
                            viewModel.callLocation()
                        } label: {
                            OptionButton(image: "phone.fill")
                        }
                        
                        Button {
                            viewModel.updateCheckInStatus(to: .checkedOut)
                        } label: {
                            OptionButton(image: "person.fill.xmark", color: .pink)
                        }
                    }
                }
                
                Text("Who's Here?")
                    .font(.title2)
                    .bold()
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 20) {
                        ForEach(1..<10) { item in
                            FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Avatar")
                                .onTapGesture {
                                    viewModel.isShowingProfileModal = true
                                }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 40)
                    .padding()
                }
                
            }
            .offset(y: -45)
            
            if viewModel.isShowingProfileModal {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.8)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
                    .zIndex(1)
                
                
                ProfileModalView(isShowingProfileModal: $viewModel.isShowingProfileModal,
                                 profile: DDGProfile(record: MockData.profile))
                .transition(.opacity.combined(with: .slide))
                .animation(.easeOut)
                .zIndex(2)
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Text("Dismiss")
                    .foregroundColor(.brandPrimary)
            }
            
            ToolbarItem(placement: .principal) {
                Text(viewModel.location.name)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.location)))
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
    
    var image: UIImage
    var firstName: String
    
    var body: some View {
        VStack {
            AvatarView(image: image, size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .minimumScaleFactor(0.75)
            .padding(.horizontal)
    }
}
