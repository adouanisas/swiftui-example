//
//  Homepage.swift
//  LeProto
//
//  Created by Ahmed Adouani on 20/01/2023.
//
// Tabbar color : https://sarunw.com/posts/swiftui-tabbaritem-color/

import SwiftUI

struct Homepage: View {
    
    @EnvironmentObject var opData: OpData
    
    @State private var selection: Item = .first
    @State private var visibility: TabBarVisibility = .visible
    
    var body: some View {
        TabBar(selection: $selection, visibility: $visibility) {
            TodayPage()
                .tabItem(for: Item.first)
            
            VStack(spacing: 0) {
                Button {
                    withAnimation {
                        visibility.toggle()
                    }
                } label: {
                    Text("Compatibilité")
                        .appFontMenu(14)
                        .foregroundColor(.black)
                }
            }
            .tabItem(for: Item.second)
            
            Text("Thème natal")
                .appFontMenu(14)
                .tabItem(for: Item.third)
            
            Text("Calendrier lunaire")
                .appFontMenu(14)
                .tabItem(for: Item.fourth)
        }
        .tabBar(style: CustomTabBarStyle())
        .tabItem(style: CustomTabItemStyle())
        .preferredColorScheme(.light)
        .navigationBarHidden(true)
        .bottomSafeAreaInset(overlayContent)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var overlayContent: some View {
        Color.white
            .frame(maxWidth: .infinity, maxHeight: UIConstants.bottomPadding)
            .background(Color.white)
    }
}


enum Item: Int, Tabbable {
    case first = 0
    case second
    case third
    case fourth
    
    var icon: String {
        switch self {
        case .first:
            return "018-crystal1"
        case .second:
            return "004-magicball1"
        case .third:
            return "021-coin1"
        case .fourth:
            return "013-moon1"
        }
    }
    
    var index: Int {
        switch self {
        case .first:
            return 0
        case .second:
            return 1
        case .third:
            return 2
        case .fourth:
            return 3
        }
    }
    
    var title: String {
        switch self {
        case .first:
            return "Aujourd'hui"
        case .second:
            return "Compatibilité"
        case .third:
            return "Thème natal"
        case .fourth:
            return "Calendrier lunaire"
        }
    }
}


struct CustomTabBarStyle: TabBarStyle {
    public func tabBar(with geometry: GeometryProxy, selectedTabIndex: Int, itemsContainer: @escaping () -> AnyView) -> some View {
        VStack(spacing: 0) {
            Color.black.frame(minHeight: 1*UIConstants.scalingFactor)
            Color.clear.frame(height: 2)
                .background(
                    Color.black
                        .frame(width: geometry.size.width/4)
                        .offset(x: (CGFloat(selectedTabIndex)/4)*geometry.size.width)
                    , alignment: .topLeading
                )
            itemsContainer()
        }
        .background(Color.white)
        .frame(height: 72.0*UIConstants.scalingFactor)
    }
    
}

struct CustomTabItemStyle: TabItemStyle {
    
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 0)
                .padding(.bottom, 13.5*UIConstants.scalingFactor)
            VStack (spacing: 0) {
                Image(icon)
                    .resizable()
                    .foregroundColor(isSelected ? .black : Color("color.tab.item.foreground"))
                    .frame(width: 24.0*UIConstants.scalingFactor, height: 24.0*UIConstants.scalingFactor)
                Text(title)
                    .appFontMenu(10)
                    .lineLimit(1)
                    .foregroundColor(isSelected ? .black : Color("color.tab.item.foreground"))
                    .padding(.top, 4*UIConstants.scalingFactor)
                    .frame(height: 13*UIConstants.scalingFactor)
                    .padding(.horizontal, 3*UIConstants.scalingFactor)
            }.frame(height: 41.0*UIConstants.scalingFactor)
            .padding(.bottom, 15.5*UIConstants.scalingFactor)
                
        }.frame(height: 70*UIConstants.scalingFactor)
    }
    
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
