//
//  SignIn06ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

struct SignIn06ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var opData: OpData
    
    init() {
        // https://stackoverflow.com/questions/57254461/how-to-change-the-background-color-for-a-form-in-swiftui
        UITableView.appearance().backgroundColor = .clear
        
        hours = hours.map({ str in
            str.replacingOccurrences(of: ":", with: " ")
        })
        
    }
    
    @State var hours = ["00     00", "00     30",
                        "01     00", "01     30",
                        "02     00", "02     30",
                        "03     00", "03     30",
                        "04     00", "04     30",
                        "05     00", "05     30",
                        "06     00", "06     30",
                        "07     00", "07     30",
                        "08     00", "08     30",
                        "09     00", "09     30",
                        "10     00", "10     30",
                        "11     00", "11     30",
                        "12     00", "12     30",
                        "13     00", "13     30",
                        "14     00", "14     30",
                        "15     00", "15     30",
                        "16     00", "16     30",
                        "17     00", "17     30",
                        "18     00", "18     30",
                        "19     00", "19     30",
                        "20     00", "20     30",
                        "21     00", "21     30",
                        "22     00", "22     30",
                        "23     00", "23     30",
    ] // 1

    @State var selectedHour = "12     30" // 2
    
    
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
                        Text("4/4")
                            .appFontBody()
                        Spacer()
                    }
                }.frame(height: 18*UIConstants.scalingFactor)
                 .padding(.top, UIConstants.signInTopMargin)
                
                Text("Horoscope quotidien")
                    .appFontH1()
                    .padding(.top, 98*UIConstants.scalingFactor)
                    
                Text("Choisis l’heure à laquelle tu veux recevoir la notification de ton horoscope.")
                    .appFontBody(14)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16*UIConstants.scalingFactor)
                
                ZStack {
                    TextValuesPicker(dataArray: $hours, selectedValue: $selectedHour, textSize: 27*UIConstants.scalingFactor, isBold: false)
                        .frame(width: 101*UIConstants.scalingFactor, height: 224*UIConstants.scalingFactor)
                    Text(":")
                        .appFontH1(27)
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
                        .offset(x: -5)
                        .frame(height: 6*UIConstants.scalingFactor)
                }.padding(.top, 100*UIConstants.scalingFactor)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, UIConstants.screenHorizontalPadding)
            
            VStack(spacing: 0) {
                Spacer()
                Button(action: {
                    opData.currentView = .loading1
                }) {
                    CommonButton("Suivant")
                }.padding(.bottom, UIConstants.signInBottomMargin)
            }.padding(.horizontal, UIConstants.screenHorizontalPadding)
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationBarHidden(true)
        
    }
}

struct SignIn06ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn06ContentView()
    }
}
