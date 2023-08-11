//
//  CustomModifiers.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 14/07/23.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
            .autocorrectionDisabled(true)
    }
}
