//
//  CommonGenderChoice.swift
//  LeProto
//
//  Created by Ahmed Adouani on 04/02/2023.
//

import SwiftUI

struct ThreeButtonState {
    var values: [Bool]
}

struct CommonGenderChoice: View {
    
    let icon: String
    let title: String
    
    let index: Int
    
    @Binding var selection: ThreeButtonState
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                for i in [0, 1, 2] {
                    var selection = selection
                    if i == index {
                        selection.values[i] = !selection.values[i]
                    } else {
                        selection.values[i] = false
                    }
                    self.selection = selection
                }
                
            } label: {
                ItemContent(icon: icon, title: title, index: index, selection: $selection)
            }.disabled(selection.values[index])
            Text(title).appFontBody()
                .frame(height: 18*UIConstants.scalingFactor)
                .padding(.top, 24*UIConstants.scalingFactor)
        }
    }
}

private struct ItemContent: View {
    
    let icon: String
    let title: String
    
    let index: Int
    
    @Binding var selection: ThreeButtonState
    
    var body: some View {
        VStack(spacing: 0) {
            Image(icon)
                .foregroundColor(selection.values[index] ? .white : .black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                        .stroke(.black, lineWidth: 2*UIConstants.scalingFactor)
                )
                .aspectRatio(1, contentMode: .fit)
                .background(
                    RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                        .foregroundColor(selection.values[index] ? .black : .white)
                        .shadow(color: .black, radius: 0, x: 3*UIConstants.scalingFactor, y: 3*UIConstants.scalingFactor)
                    
                )
        }
    }
}

private struct CommonGenderChoiceTestView: View {
    
    @State private var selection = ThreeButtonState(values: [true, false, false])
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            CommonGenderChoice(icon: "SignIn04_gender_femme", title: "Homme", index: 1, selection: $selection)
                .frame(width: 116*UIConstants.scalingFactor)
            Spacer()
        }
    }
}

struct CommonGenderChoice_Previews: PreviewProvider {
    
    static var previews: some View {
        CommonGenderChoiceTestView()
    }
}
