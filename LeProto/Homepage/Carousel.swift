//
//  Carousel.swift
//  LeProto
//
//  Created by Ahmed Adouani on 22/01/2023.
//

import Foundation
import SwiftUI

struct Carousel<Content: View,T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    
    init(spacing: CGFloat = 16*UIConstants.scalingFactor,
         trailingSpace: CGFloat = 48*UIConstants.scalingFactor,
         index: Binding<Int>,items: [T],
         @ViewBuilder content: @escaping (T)->Content){
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View{
        
        GeometryReader { proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing){
                ForEach(list){item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace, height: 100*UIConstants.scalingFactor)
                }
            }
            .padding(.horizontal,spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        let offsetX = value.translation.width
                        var progress = -offsetX / width
                        if abs(progress) > 0.2 {
                            progress = (progress/abs(progress)) * 0.6
                        }
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        currentIndex = index
                    })
                    .onChanged({ value in
                        let offsetX = value.translation.width
                        var progress = -offsetX / width
                        if abs(progress) > 0.2 {
                            progress = (progress/abs(progress)) * 0.6
                        }
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}

struct Card: Identifiable{
    var id = UUID().uuidString
    var icon: String
    var title: String
    var text: String
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CarousselContentView()
        }
    }
}

struct CardContentView: View {
    
    let icon: String
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Image(icon).resizable()
                .frame(width: 88, height: 73.77)
                .padding(.leading, 16)
                .padding(.trailing, 32)
            //Spacer()
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .appFontH2()
                        //.padding()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                HStack {
                    Text(text)
                        //.padding()
                        .appFontBody()
                        .foregroundColor(.black)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.top, 8)
            }.padding(.trailing, 16)
        }
    }
}

struct CarousselContentView: View {
    
    @EnvironmentObject var opData: OpData
    
    @State var currentIndex: Int = 0
    @State var cards: [Card] = []
    
    var body: some View {
        VStack() {
            Carousel(index: $currentIndex, items: cards) { card in
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    CardContentView(icon: card.icon, title: card.title, text: card.text)
                    .frame(width: size.width, height: 136*UIConstants.scalingFactor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                            .stroke(.black, lineWidth: 2*UIConstants.scalingFactor)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                            .foregroundColor(.white)
                        
                    ).background(
                        RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                            .shadow(color: .black, radius: 0, x: 3*UIConstants.scalingFactor, y: 3*UIConstants.scalingFactor)
                        
                    )
                    
                }
            }
        }
        .frame(height: 136*UIConstants.scalingFactor)
        .onAppear {
            cards.append(contentsOf:
                [
                    Card(icon: "icon-tab1",
                     title: "Amour",
                     text: "Évites les gaffes et tes initiatives pourront très bien tomber et combler votre partenaire."),
                Card(icon: "icon-tab2",
                     title: "Travail",
                     text: "Pour atteindre votre but, vous y mettrez le prix."),
                Card(icon: "icon-tab3",
                     title: "Recommandation",
                     text: "Voici venu le temps de prendre de solides habitudes alimentaires raisonnables !"),
                Card(icon: "icon-tab4",
                     title: "Défi du jour",
                     text: "Osez la fantaisie.")
                ]
            )
        }
    }
}
