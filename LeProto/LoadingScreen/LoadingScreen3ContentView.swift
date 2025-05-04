//
//  LoadingScreen3ContentView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 04/02/2023.
//

import SwiftUI
import NavigationBackport

struct LoadingScreen3ContentView: View {
    
    let automaticTransition: Bool
    
    init(automaticTransition: Bool = true) {
        self.automaticTransition = automaticTransition
    }
    
    @State private var showHomePage = false
    
    var body: some View {
        // NavigationStack porting for earlier versions
        NBNavigationStack {
            NonAnimatedView()
                .nbNavigationDestination(isPresented: $showHomePage) {
                    Homepage()
                }.navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            guard automaticTransition else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    showHomePage = true
                }
            }
        }
    }
}

struct NonAnimatedView: View {
    
    @EnvironmentObject var opData: OpData
    
    @State var titleHeight = 28.0*UIConstants.scalingFactor
    
    @State private var offset: CGFloat = 120*UIConstants.scalingFactor
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Text("Bonjour Marc,")
                        .appFontH1()
                        .foregroundColor(.white)
                        .frame(height: titleHeight)
                        .multilineTextAlignment(.center)
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
                .offset(CGSize(width: 0, height: (geometry.size.height/2 - offset - 37)*UIConstants.scalingFactor))
            }
        }
    }
}

struct LoadingScreen3ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen3ContentView(automaticTransition: false)
    }
}

