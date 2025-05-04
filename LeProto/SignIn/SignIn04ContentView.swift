//
//  SignIn04ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI
//import Introspect

struct ViewWidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct SignIn04ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var opData: OpData
    
    @State var situations = [
        "Célibataire",
        "Fiancé(e)",
        "En relation",
        "Marié(e)",
        "C’est compliqué"
    ] // 1
    @State var selectedSituation = "En relation" // 2
    
    
    @State private var maxWidth = CGFloat.zero
    @State private var width = CGFloat.infinity
    
    
    @State private var selection = ThreeButtonState(values: [false, false, false])
    
    var body: some View {
        ZStack {
            Image("SignIn03_bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                        .frame(width: 15*UIConstants.scalingFactor, height: 50*UIConstants.scalingFactor)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("2/4")
                            .appFontBody()
                        Spacer()
                    }
                }.frame(height: 18*UIConstants.scalingFactor)
                    .padding(.top, UIConstants.signInTopMargin)
                Text("Dis-nous en plus sur \ntes relations")
                    .appFontH1(27.08)
                    .multilineTextAlignment(.center)
                    .frame(height: 54*UIConstants.scalingFactor)
                    .padding(.top, 98*UIConstants.scalingFactor)
                VStack(spacing: 0) {
                    HStack(spacing: 16*UIConstants.scalingFactor) {
                        CommonGenderChoice(icon: "SignIn04_gender_homme", title: "Homme", index: 0, selection: $selection)
                        CommonGenderChoice(icon: "SignIn04_gender_non_binaire", title: "Non binaire", index: 1, selection: $selection)
                        CommonGenderChoice(icon: "SignIn04_gender_femme", title: "Femme", index: 2, selection: $selection)
                    }
                }
                .padding(.top, 48*UIConstants.scalingFactor)
                Text("Ton statut actuel fournit un aperçu de\n ta vie amoureuse.")
                    .appFontBody()
                    .frame(height: 36*UIConstants.scalingFactor)
                    .multilineTextAlignment(.center)
                    .padding(.top, 48*UIConstants.scalingFactor)
                
                TextValuesPicker(dataArray: $situations, selectedValue: $selectedSituation, itemWidth: 153*UIConstants.scalingFactor)
                    .padding(.top, 56*UIConstants.scalingFactor)
                    .frame(height: 144*UIConstants.scalingFactor)
                    
                Spacer()
                
                
            }.padding(.horizontal, UIConstants.screenHorizontalPadding)
            
            VStack(spacing: 0) {
                Spacer()
                NavigationLink(destination: SignIn05ContentView()) {
                    CommonButton("Suivant")
                }.padding(.bottom, UIConstants.signInBottomMargin)
            }.padding(.horizontal, UIConstants.screenHorizontalPadding)
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationBarHidden(true)
    }
}

struct SignIn04ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn04ContentView()
    }
}
