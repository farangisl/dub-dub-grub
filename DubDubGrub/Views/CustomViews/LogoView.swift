//
//  LogoView.swift
//  DubDubGrub
//
//  Created by Farangis Makhmadyorova on 01/08/23.
//

import SwiftUI

struct LogoView: View {
    
    var frameWith: CGFloat
    
    var body: some View {
        Image(decorative: "ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWith)
            
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWith: 250)
    }
}
