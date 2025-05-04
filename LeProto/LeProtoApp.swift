//
//  LeProtoApp.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

enum CurrentView: Int {
    case splash
    case signIn
    case loading1
    case loading2
    case loading3
    case homepage
    case caroussel
    case signIn06
}

class OpData : ObservableObject {
    @Published var currentView = CurrentView.splash
    @Published var showSplash = false
}

@main
struct LeProtoApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    private var opDat = OpData()

    @State var isActivated = false
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(opDat)
        }.onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if isActivated {
                    self.opDat.showSplash = false
                }
                self.isActivated = true
                print("Active")
            } else if newPhase == .inactive {
                if isActivated {
                    self.opDat.showSplash = true
                }
            } else if newPhase == .background {
                print("Active")
            }
        }
    }
}
