//
//  CommonBiorithmItem.swift
//  LeProto
//
//  Created by Ahmed Adouani on 11/02/2023.
//

import SwiftUI

struct CommonBiorithmItem: View {
    let percent: Int
    let title: String
    
    init(title: String, percent: Int) {
        self.percent = percent
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("\(percent)%")
                            .appFontH2()
                        (percent > 0 ? Image("Arrow-haut") : Image("Arrow-bas"))
                            .foregroundColor(.black)
                            .frame(width: 17*UIConstants.scalingFactor, height: 0*UIConstants.scalingFactor)
                            
                    }
                    Text(title).appFontBody()
                }.frame(height: 46*UIConstants.scalingFactor)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.overlay(
            RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                .stroke(.black, lineWidth: 2*UIConstants.scalingFactor)
        )
        .aspectRatio(1, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 0, x: 3*UIConstants.scalingFactor, y: 3*UIConstants.scalingFactor)
            
        )
    }
}

struct CommonBiorithmItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Spacer()
            CommonBiorithmItem(title: "Physique", percent: 96)
                .frame(width: 116*UIConstants.scalingFactor)
            Spacer()
        }
    }
}
