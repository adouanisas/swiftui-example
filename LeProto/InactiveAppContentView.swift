//
//  InactiveAppContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 19/01/2023.
//

import SwiftUI

struct InactiveAppContentView: View {
    
    var body: some View {
        ZStack {
            Color
                .white.ignoresSafeArea()
            Image("SignIn01_bg")
                .resizable()
                .scaledToFill()
            
            VStack(spacing: 0) {
                Image("SignIn01_logo")
                    .imageScale(.small)
                    .foregroundColor(.accentColor)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct InactiveAppContentView_Previews: PreviewProvider {
    static var previews: some View {
        InactiveAppContentView()
    }
}
