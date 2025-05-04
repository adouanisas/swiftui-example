//
//  MainView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 19/01/2023.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var opData: OpData

    var body: some View {
        ZStack {
            switch(opData.currentView){
            case .splash:
                SignIn01ContentView()
                    .environmentObject(opData)
                
            case .signIn:
                SignIn02ContentView()
                    .environmentObject(opData)

            case .loading1:
                LoadingScreen1ContentView()
                    .environmentObject(opData)
                
            case .loading2:
                LoadingScreen2ContentView()
                    .environmentObject(opData)
                
            case .loading3:
                LoadingScreen3ContentView()
                
            case .homepage:
                Homepage()
                    .transition(.move(edge: .trailing))
                    .environmentObject(opData)
            
            case .caroussel:
                CarousselContentView()
                    .environmentObject(opData)
                
            case .signIn06:
                SignIn06ContentView().environmentObject(opData)
            }
            
            VStack(spacing: 0) {
                if opData.showSplash {
                    InactiveAppContentView()
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let opDat = OpData()
        MainView().environmentObject(opDat)
    }
}
