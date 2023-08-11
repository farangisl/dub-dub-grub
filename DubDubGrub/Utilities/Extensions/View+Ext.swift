//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 14/07/23.
//

import SwiftUI

extension View {
    
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }

    
    func embedInScrollView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.frame(minHeight: geometry.size.height, maxHeight: .infinity)
            }
        }
    }
}
