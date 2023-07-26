//
//  DDGButton.swift
//  DubDubGrub
//
//  Created by IMacIBT1 on 14/07/23.
//

import SwiftUI

struct DDGButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal, 60)
            .padding(.vertical, 5)
    }
}

struct DDGButton_Previews: PreviewProvider {
    static var previews: some View {
        DDGButton(title: "Text Button")
    }
}
