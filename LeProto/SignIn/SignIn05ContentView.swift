//
//  SignIn05ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI
import Combine

struct SignIn05ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var opData: OpData
    
    @State var firstName: String = ""
    
    @State private var keyboardHeight: CGFloat = 0
    
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
                        Text("3/4")
                            .appFontBody()
                        Spacer()
                    }
                }.frame(height: 18*UIConstants.scalingFactor)
                 .padding(.top, UIConstants.signInTopMargin)
                Text("Il ne nous manque \nque ton prénom")
                    .appFontH1()
                    .multilineTextAlignment(.center)
                    .frame(height: 58*UIConstants.scalingFactor)
                    .padding(.top, 98*UIConstants.scalingFactor)
                    
                Text("Nous sommes heureux de te voir parmi nous.")
                    .appFontBody(14)
                    .multilineTextAlignment(.center)
                    .frame(height: 38*UIConstants.scalingFactor)
                    .padding(.top, 16*UIConstants.scalingFactor)
                
                VStack(spacing: 0) {
                    TextField("Prénom", text: $firstName)
                        .appFontH1()
                        .multilineTextAlignment(.center)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .frame(height: 27*UIConstants.scalingFactor)
                    Divider()
                        .modifier(OverlayBlack())
                        .padding(.top, 11*UIConstants.scalingFactor)
                }.frame(height: 38*UIConstants.scalingFactor)
                    .padding(.top,  209*UIConstants.scalingFactor)
                
                if keyboardHeight != 0 {
                    NavigationLink(destination: SignIn06ContentView()) {
                        CommonButton("Suivant")
                    }.padding(.top, 40*UIConstants.scalingFactor)
                    .padding(.bottom, 20*UIConstants.scalingFactor)
                }
                
                Spacer()
                
            }.padding(.horizontal, UIConstants.screenHorizontalPadding)
                .padding(.bottom, keyboardHeight)
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0
                }
            
            if keyboardHeight == 0 {
                VStack(spacing: 0) {
                    Spacer()
                    NavigationLink(destination: SignIn06ContentView()) {
                        CommonButton("Suivant")
                    }.padding(.bottom, UIConstants.signInBottomMargin)
                }.padding(.horizontal, UIConstants.screenHorizontalPadding)
                .edgesIgnoringSafeArea(.all)
            }
        }
        .statusBar(hidden: keyboardHeight != 0)
        .navigationBarHidden(true)
    }
}

struct SignIn05ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn05ContentView()
    }
}
