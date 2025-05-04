//
//  SignIn03ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI
import Combine

struct SignIn03ContentView: View {
    
    @EnvironmentObject var opData: OpData
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            Image("SignIn03_bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack(spacing: 0) {
                    Text("1/4")
                        .appFontBody()
                        .frame(height: 18*UIConstants.scalingFactor)
                        .padding(.top, UIConstants.signInTopMargin)
                    
                    Text("Parles-nous de ta naissance")
                        .appFontH1()
                        .frame(height: 27*UIConstants.scalingFactor)
                        .padding(.bottom, 16*UIConstants.scalingFactor)
                        .padding(.top, 98*UIConstants.scalingFactor)
                    
                    Text("Ces éléments sont importants pour connaitre ton horoscope personnalisé.")
                        .appFontBody()
                        .frame(height: 36*UIConstants.scalingFactor)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 72*UIConstants.scalingFactor)
                    
                    
                    BirthDaySection()
                        .padding(.bottom, 40*UIConstants.scalingFactor)
                    BirthHourSection()
                        .padding(.bottom, 40*UIConstants.scalingFactor)
                    BirthPlaceSection()
                    
                    if keyboardHeight == 0 {
                        Spacer()
                    } else {
                        Color.clear.frame(height: 40*UIConstants.scalingFactor)
                    }
                    
                    NavigationLink(destination: SignIn04ContentView()) {
                        CommonButton("Suivant")
                    }
                }
                .padding(.horizontal, UIConstants.screenHorizontalPadding)
                
            }.statusBar(hidden: keyboardHeight != 0)
                .padding(.bottom, max(UIConstants.signInBottomMargin, keyboardHeight+20*UIConstants.scalingFactor))
                .edgesIgnoringSafeArea(.all)
            
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0
                }
            
        }
        .navigationBarHidden(true)
        .environment(\.locale, .init(identifier: "fr"))
    }
}

struct SignIn03ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn03ContentView()
    }
}

struct BirthDaySection: View {
    
    @State private var birthDate = Date()
    
    private static var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Date d’anniversaire")
                    .appFontBody()
                    .opacity(0.5)
                Spacer()
            }
            .frame(height: 18*UIConstants.scalingFactor)
            .padding(.bottom, 16*UIConstants.scalingFactor)
            
            ZStack {
                HStack {
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date").appFontBody()
                    }.labelsHidden()
                        .datePickerStyle(.automatic)
                        .frame(height: 0)
                        .clipped()
                    Spacer()
                }
                HStack {
                    Text(Self.dayFormatter.string(from: birthDate))
                        .appFontH1()
                        .allowsHitTesting(false)
                    Spacer()
                }.frame(height: 27*UIConstants.scalingFactor)
            }.frame(height: 27*UIConstants.scalingFactor)
            
            Divider()
                .modifier(OverlayBlack())
                .padding(.top, 11*UIConstants.scalingFactor)
        }.frame(height: 72*UIConstants.scalingFactor)
    }
}


struct BirthHourSection: View {
    
    @State private var birthHour = Date()
    
    private static var hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Heure de naissance")
                    .appFontBody()
                    .opacity(0.5)
                Spacer()
                Text("Je ne sais pas")
                    .appFontBody(12*UIConstants.scalingFactor)
                    .underline()
            }.frame(height: 18*UIConstants.scalingFactor)
                .padding(.bottom, 16*UIConstants.scalingFactor)
            
            ZStack {
                HStack {
                    DatePicker(selection: $birthHour, in: ...Date(), displayedComponents: .hourAndMinute) {
                        Text("Select a date").appFontBody()
                    }.labelsHidden()
                        .datePickerStyle(.automatic)
                        .frame(height: 0)
                        .clipped()
                    Spacer()
                }
                
                HStack {
                    Text(Self.hourFormatter.string(from: birthHour))
                        .appFontH1()
                        .frame(height: 27*UIConstants.scalingFactor)
                        .allowsHitTesting(false)
                    Spacer()
                }
            }
            Divider()
                .modifier(OverlayBlack())
                .padding(.top, 11*UIConstants.scalingFactor)
        }.frame(height: 72*UIConstants.scalingFactor)
    }
}

struct BirthPlaceSection: View {
    
    @State private var birthPlace = "Paris"
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Lieu de naissance")
                    .appFontBody()
                    .opacity(0.5)
                Spacer()
            }.frame(height: 18*UIConstants.scalingFactor)
                .padding(.bottom, 16*UIConstants.scalingFactor)
            
            HStack {
                TextField("", text: $birthPlace)
                    .appFontH1()
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .frame(height: 27*UIConstants.scalingFactor)
                Spacer()
            }
            Divider()
                .modifier(OverlayBlack())
                .padding(.top, 11*UIConstants.scalingFactor)
        }.frame(height: 72*UIConstants.scalingFactor)
    }
}

