//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 14/07/23.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
}
