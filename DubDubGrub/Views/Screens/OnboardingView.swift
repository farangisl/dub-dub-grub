//
//  OnboardingView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 20/07/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameWith: 250)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                
                OnboardInfoView(imageName: "building.2.crop.circle",
                                title: "Restaurant Locations",
                                description: "Find places to dine adound the convention center")
                
                OnboardInfoView(imageName: "checkmark.circle",
                                title: "Check In",
                                description: "Let other iOS Devs know where you are")
                
                OnboardInfoView(imageName: "person.2.circle",
                                title: "Find Friends",
                                description: "See where other iOS Devs are and join the party")
            }
            .padding(.horizontal, 40)
            Spacer()
        }        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

fileprivate struct OnboardInfoView: View {
    
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(description)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
        }
    }
}
