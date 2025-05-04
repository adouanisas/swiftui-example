//
//  ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

struct SignIn01ContentView: View {
    
    let automaticTransition: Bool
    
    init(automaticTransition: Bool = true) {
        self.automaticTransition = automaticTransition
    }
    
    @EnvironmentObject var opData: OpData
    
    var body: some View {
        ZStack {
            Image("SignIn01_bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                RotatingView()
                    .frame(
                        width: 138*UIConstants.scalingFactor,
                        height: 134*UIConstants.scalingFactor)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                if automaticTransition {
                    withAnimation {
                        opData.currentView = .signIn
                    }
                }
            }
        }
    }
}

struct RotatingView: View {
    
    @State private var rotationDegree = 0.0
    private var timeCurveAnimation: Animation {
        return Animation.timingCurve(0.5, 0.8, 0.8, 0.3, duration: 100)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image("SignIn01_logo")
            .resizable()
            .foregroundColor(.accentColor)
            .rotationEffect(.degrees(rotationDegree))
            .onAppear() {
                withAnimation(self.timeCurveAnimation) {
                    self.rotationDegree = 720.0
                }
            }
    }
    
}


struct SignIn01ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn01ContentView(automaticTransition: false)
    }
}
