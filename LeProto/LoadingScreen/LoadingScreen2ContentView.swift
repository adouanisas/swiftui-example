//
//  LoadingScreen3ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 20/01/2023.
//

import SwiftUI

struct LoadingScreen2ContentView: View {
    
    
    @EnvironmentObject var opData: OpData
    
    let automaticTransition: Bool
    
    init(automaticTransition: Bool = true) {
        self.automaticTransition = automaticTransition
    }
    
    var body: some View {
        AnimatedView(automaticTransition: automaticTransition)
            .preferredColorScheme(.light)
    }
}

struct AnimatedView: View {
    
    @EnvironmentObject var opData: OpData
    
    @State var textChanged = false
    
    @State var titleHeight = 74.0
    
    @State private var offset: CGFloat = 0
    
    let automaticTransition: Bool
    
    private var timeCurveAnimation: Animation {
        return Animation.spring(
            response: 1,
            dampingFraction: 1,
            blendDuration: 0
        ).delay(0)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack {
                        if !textChanged {
                            Text("Nous préparons \nton rapport quotidien...")
                                .appFontH1()
                                .foregroundColor(.white)
                                .frame(height: titleHeight)
                                .multilineTextAlignment(.center)
                        } else {
                            VStack(spacing: 0) {
                                Text("Bonjour Marc,")
                                    .appFontH1()
                                    .foregroundColor(.white)
                                    .frame(height: titleHeight)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .frame(height: titleHeight)
                    .padding(.bottom, 8*UIConstants.scalingFactor)
                    
                    Text("Tu es balance.")
                        .foregroundColor(.white)
                        .appFontBody()
                        .frame(height: 18*UIConstants.scalingFactor)
                        .padding(.bottom, 40*UIConstants.scalingFactor)
                    
                    Image("LoadingScreen03_Group")
                        .resizable()
                        .frame(width: 260*UIConstants.scalingFactor, height: 260*UIConstants.scalingFactor)
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(
                    CGSize(width: 0,
                           height: (geometry.size.height/2 - offset - 37)*UIConstants.scalingFactor
                    )
                )
                .animation(timeCurveAnimation)
                .animationObserver(for: Float(offset)) { progress in
                    if progress > 20 {
                        if textChanged {
                            return
                        }
                        textChanged = true
                    }
                } onComplete: {
                    withAnimation {
                        titleHeight = 28.0*UIConstants.scalingFactor
                    }
                    
                    if automaticTransition {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            opData.currentView = .loading3
                        }
                    }
                }
            }
        }.onAppear {
            withAnimation {
                offset = 120*UIConstants.scalingFactor
            }
        }
    }
}

struct LoadingScreen2ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen2ContentView(automaticTransition: false)
    }
}
