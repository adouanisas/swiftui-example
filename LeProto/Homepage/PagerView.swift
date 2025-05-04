//
//  PagerView.swift
//  LeProto
//
//  Created by Ahmed Adouani on 12/02/2023.
//

import SwiftUI

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        let width = UIConstants.screenWidth
        HStack(spacing: 0) {
            self.content.frame(width: width).clipped()
        }
        .frame(width: width, alignment: .leading)
        .offset(x: -CGFloat(self.currentIndex) * width)
        .offset(x: self.translation)
        .animation(.interactiveSpring())
        .gesture(
            DragGesture().updating(self.$translation) { value, state, _ in
                state = value.translation.width
            }.onEnded { value in
                let offset = value.translation.width / width
                let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
            }
        )
    }
}

private struct ContentView: View {
    @State private var currentPage = 0

    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            Color.blue
            Color.red
            Color.green
        }
    }
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
