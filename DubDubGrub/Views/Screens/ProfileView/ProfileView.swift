//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 12/07/23.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
  
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    NameBackgroundView()
                    
                    HStack(spacing: 16) {
                        ZStack {
                            AvatarView(image: viewModel.avatar, size: 84)
                            EditImage()
                        }
                        .padding(.leading)
                        .onTapGesture { viewModel.isShowingPhotoPicker = true }
                        
                        VStack(spacing: 1) {
                            TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                            TextField("Last Name", text: $viewModel.lastName).profileNameStyle()
                            TextField("Company Name", text: $viewModel.companyName).font(.callout)
                        }
                        .padding(.trailing)
                    }
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack{
                        CharactersRemainView(currentCount: viewModel.bioText.count)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Label("Check Out", systemImage: "mappin.and.ellipse")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.pink)
                        .font(.callout)
                        .fontWeight(.semibold)
                    }
                    
                    TextEditor(text: $viewModel.bioText)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1))
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
                .padding()
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear {
            viewModel.getProfile()
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
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

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .imageScale(.small)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    
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
