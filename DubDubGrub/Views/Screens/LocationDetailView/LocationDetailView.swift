//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 13/07/23.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ZStack {
            VStack {
                BannerImageView(image: viewModel.location.bannerImage)
                    .accessibilityHidden(true)
                AddressView(address: viewModel.location.address)
                DescriptionView(text: viewModel.location.description)
                ActionButtonHStack(viewModel: viewModel)
                GridHeaderTextView(number: viewModel.checkedInProfiles.count)
                AvatarGridView(viewModel: viewModel)
                if viewModel.checkedInProfiles.isEmpty { Spacer() }
            }
            .accessibilityHidden(viewModel.isShowingProfileModal)
            
            if viewModel.isShowingProfileModal {
                FullScreenBlackTransparencyView()
                ProfileModalView(isShowingProfileModal: $viewModel.isShowingProfileModal,
                                 profile: viewModel.selectedProfile!)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .sheet(isPresented: $viewModel.isShowingProfileSheet) {
            NavigationStack {
                ProfileSheetView(profile: viewModel.selectedProfile!)
                    .toolbar {
                        Button("Dismiss") {
                            viewModel.isShowingProfileSheet = false
                        }
                    }
            }
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .toolbar {
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
            LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.sultanbey)))
        }
    }
}


fileprivate struct OptionButton: View {
    
    var image: String = ""
    var color = Color.brandPrimary
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaleEffect(0.4)
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundColor(.white)
            .background(color.gradient)
            .clipShape(Circle())
    }
}


fileprivate struct FirstNameAvatarView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    var profile: DDGProfile
    
    var body: some View {
        VStack {
            AvatarView(image: profile.avatarImage, size: dynamicTypeSize >= .accessibility3 ? 100 : 64)
            
            Text(profile.firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(Text("Show's \(profile.firstName) profile pop up."))
        .accessibilityLabel(Text("\(profile.firstName) \(profile.lastName)"))
    }
}


fileprivate struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
            .accessibilityHidden(true)
    }
}


fileprivate struct AddressView: View {
    
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


fileprivate struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
        //            .lineLimit(4)
        //            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .minimumScaleFactor(0.75)
            .padding(.horizontal, 20)
    }
}


fileprivate struct ActionButtonHStack: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                viewModel.getDirectionsToLocation()
            } label: {
                OptionButton(image: "location.fill")
            }
            .accessibilityLabel(Text("Get directions"))
            
            Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                OptionButton(image: "network")
            })
            .accessibilityRemoveTraits(.isButton)
            .accessibilityLabel(Text("Go to website"))
            
            Button {
                viewModel.callLocation()
            } label: {
                OptionButton(image: "phone.fill")
            }
            .accessibilityLabel(Text("Call location"))
            
            if let _ = CloudKitManager.shared.profileRecordID {
                Button {
                    viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn)
                } label: {
                    OptionButton(image: viewModel.buttonImageTitle, color: viewModel.buttonColor)
                }
                .accessibilityLabel(Text(viewModel.buttonA11yLabel))
                .disabled(viewModel.isLoading)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
    }
}


fileprivate struct GridHeaderTextView: View {
    
    var number: Int
    
    var body: some View {
        Text("Who's Here?")
            .font(.title2)
            .bold()
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel(Text("Who's Here? \(number) checked in"))
            .accessibilityHint(Text("Bottom section is scrollable"))
    }
}


fileprivate struct GridEmptyStateTextView: View {
    
    var body: some View {
        Text("Nobody's Here 😔")
            .bold()
            .font(.title2)
            .foregroundColor(.secondary)
            .padding(.top, 30)
    }
}


fileprivate struct FullScreenBlackTransparencyView: View {
    
    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.8)
            .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.35)))
            .zIndex(1)
            .accessibilityHidden(true)
    }
}


fileprivate struct AvatarGridView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @ObservedObject var viewModel: LocationDetailViewModel

    var body: some View {
        ZStack {
            if viewModel.checkedInProfiles.isEmpty {
                GridEmptyStateTextView()
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.determineColumns(for: dynamicTypeSize), spacing: 20) {
                        ForEach(viewModel.checkedInProfiles) { profile in
                            FirstNameAvatarView(profile: profile)
                            //ForEach(0..<17) { profile in
                            //FirstNameAvatarView(profile: DDGProfile(record: MockData.profile))
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.show(profile, in: dynamicTypeSize)
                                    }                                    
                                }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 40)
                    .padding()
                }
            }
            
            if viewModel.isLoading { LoadingView() }
        }
    }
}
