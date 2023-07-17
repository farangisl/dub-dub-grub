//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 12/07/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var companyName = ""
    
    @State private var bioText: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        EditImage()
                    }
                    .padding(.leading)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .profileNameStyle()
                        
                        TextField("Last Name", text: $lastName)
                            .profileNameStyle()
                        
                        TextField("Company Name", text: $companyName)
                            .font(.callout)
                    }
                    .padding(.trailing)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    CharactersRemainView(currentCount: bioText.count)
                    
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
                
                TextEditor(text: $bioText)
                    .frame(height: 100)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 1)
                    }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                
            } label: {
                DDGButton(title: "Create Profile")
            }
            .buttonStyle(.borderedProminent)
            .tint(.brandPrimary)
            .padding()
        }
        .navigationTitle("Profile")
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
