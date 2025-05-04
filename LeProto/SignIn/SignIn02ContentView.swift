//
//  ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

struct SignIn02ContentView: View {
    
    @EnvironmentObject var opData: OpData
    
    @State var loaded = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Image("SignIn02_bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Spacer()
                    Image("SignIn02_logo")
                        .resizable()
                        .frame(
                            width: 38*UIConstants.scalingFactor,
                            height: 37*UIConstants.scalingFactor)
                        .padding(.bottom, 12*UIConstants.scalingFactor)
                    Text("Bienvenue sur")
                        .appFontBody()
                        .frame(height: 17.6*UIConstants.scalingFactor)
                        .padding(.bottom, 8*UIConstants.scalingFactor)
                    Text("Universe Within")
                        .appFontH1()
                        .frame(height: 27*UIConstants.scalingFactor)
                    
                    Text("Merci de répondre à quelques questions sur toi pour découvrir l’univers en toi.  ")
                        .appFontBody()
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 16*UIConstants.scalingFactor, leading: 0, bottom: 24*UIConstants.scalingFactor, trailing: 0))
                    
                    
                    NavigationLink(destination: SignIn03ContentView()) {
                        CommonButton("Commencer")
                    }
                    Spacer()
                }.animation(nil)
                .padding(.horizontal, UIConstants.screenHorizontalPadding)
                
                VStack(spacing: 0) {
                    Spacer()
                    Image("SignIn02_illu")
                        .resizable()
                        .scaledToFit()
                        .frame(idealHeight: 10*UIConstants.scalingFactor)
                        .background(RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(.clear))
                        .aspectRatio(contentMode: .fit)
                        .transition(.move(edge: .bottom))
                        .if(!loaded) { view in
                            // We only apply this background color if shouldApplyBackground is true
                            view.opacity(0)
                        }
                }
            }
            .scaleEffect(1)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        loaded = true
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
}

struct SignIn02ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn02ContentView()
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
