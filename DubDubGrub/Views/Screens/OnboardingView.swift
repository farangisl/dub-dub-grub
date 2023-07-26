//
//  OnboardingView.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 20/07/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowingOnboardView: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardView = false
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            Image("ddg-map-logo")
                .resizable()
                .scaledToFit()
                .frame(height: 125)
                .padding()
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
        OnboardingView(isShowingOnboardView: .constant(true))
    }
}

struct OnboardInfoView: View {
    
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
