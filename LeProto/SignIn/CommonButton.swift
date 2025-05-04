//
//  CommonButton.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

struct CommonButton: View {
    
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .appFontH2()
            .padding()
            .foregroundColor(.black)
            .frame(minWidth: 0, maxWidth: UIConstants.buttonMaxWidth)
            .frame(height: UIConstants.buttonHeight)
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.buttonCornerRadius)
                    .stroke(.black, lineWidth: UIConstants.buttonBorderLineWidth)
            )
            .background(
                RoundedRectangle(cornerRadius: UIConstants.buttonCornerRadius)
                    .foregroundColor(.white)
                    .shadow(color: .black,
                            radius: 0,
                            x: UIConstants.buttonBorderShadowOffset,
                            y: UIConstants.buttonBorderShadowOffset)
                
            )
    }
}

