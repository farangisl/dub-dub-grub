//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 12/07/23.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @FocusState private var focusedTextField: ProfileTextField?
    
    enum ProfileTextField {
        case  firstName, lastName, companyName, bio
    }
  
    var body: some View {
        ZStack {
            VStack {
                    HStack(spacing: 16) {
                        ProfileImageView(image: viewModel.avatar)
                        .onTapGesture { viewModel.isShowingPhotoPicker = true }
                        
                        VStack(spacing: 1) {
                            TextField("First Name", text: $viewModel.firstName)
                                .profileNameStyle()
                                .focused($focusedTextField, equals: .firstName)
                                .onSubmit { focusedTextField = .lastName }
                                .submitLabel(.next)
                            
                            TextField("Last Name", text: $viewModel.lastName)
                                .profileNameStyle()
                                .focused($focusedTextField, equals: .lastName)
                                .onSubmit { focusedTextField = .companyName }
                                .submitLabel(.next)
                            
                            TextField("Company Name", text: $viewModel.companyName)
                                .font(.callout)
                                .focused($focusedTextField, equals: .companyName)
                                .onSubmit { focusedTextField = .bio }
                                .submitLabel(.next)
                        }
                        .padding(.trailing)
                    }
                    .padding(.vertical)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        CharactersRemainView(currentCount: viewModel.bioText.count)
                            .accessibilityAddTraits(.isHeader)
                        Spacer()
                        
                        if viewModel.isCheckedIn {
                            Button {
                                viewModel.checkOut()
                            } label: {
                                CheckOutButton()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.grubRed)
                            .disabled(viewModel.isLoading)
                        }
                    }
                    
                    TextField("Enter your bio", text: $viewModel.bioText, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(4...6)
                        .focused($focusedTextField, equals: .bio)
                        .accessibilityHint(Text("This TextField has a 100 character maximum."))
                    
//                    TextField("", text: $bioText, axis: .vertical)
//                        .padding(EdgeInsets(top: 16, leading: 10, bottom: 16, trailing: 10))
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(5, reservesSpace: true)
//                        .padding(.horizontal)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(lineWidth: 2)
//                                .padding(.horizontal)
//                                .foregroundColor(Color(.systemGray))
//                        )

                    
//                    BioTextEditor(text: $viewModel.bioText)
//                        .focused($focusedTextField, equals: .bio)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    viewModel.determineButtonAction()
                } label: {
                    DDGButton(title: viewModel.buttonTitle)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") {
                        focusedTextField = nil
                    }
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        
        .navigationTitle("Profile")
        .ignoresSafeArea(.keyboard)
        .task {
            viewModel.getProfile()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
        }
    }    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}


fileprivate struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}


fileprivate struct ProfileImageView: View {
    
    var image: UIImage
    var body: some View {
        ZStack {
            AvatarView(image: image, size: 84)
            
            Image(systemName: "square.and.pencil")
                .imageScale(.small)
                .foregroundColor(.white)
                .offset(y: 30)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("Profile photo"))
        .accessibilityHint(Text("Opens the iPhone's photo picker"))
        .padding(.leading)
    }
}


fileprivate struct CharactersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : .pink)
        +
        Text(" Characters Remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}


struct CheckOutButton: View {
    
    var body: some View {
        Label("Check Out", systemImage: "mappin.and.ellipse")
            .foregroundColor(.white)
            .font(.callout)
            .fontWeight(.semibold)
            .accessibilityLabel(Text("Check out of current location"))
    }
}


struct BioTextEditor: View {
    
    var text: Binding<String>
    var body: some View {
        TextEditor(text: text)
            .frame(height: 100)
            .overlay { RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1) }
            .accessibilityHint(Text("This TextField has a 100 character maximum."))
    }
}
