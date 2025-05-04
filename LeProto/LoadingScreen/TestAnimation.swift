//
//  TestAnimation.swift
//  LeProto
//
//  Created by Ahmed Adouani on 29/01/2023.
//

import SwiftUI

struct TestAnimation: View {
    
    @State var isTextAnimated: Bool = false
    @Namespace var namespace
    
    
    var body: some View {
        VStack(spacing: 0) {
            if isTextAnimated {
                Text("New text appeared")
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .offset(y: 300)
            } else {
                Text("This is basic text")
                    .matchedGeometryEffect(id: "title", in: namespace)
            }
            Button {
                withAnimation {
                    isTextAnimated.toggle()
                }
            } label: {
                Text("Press")
            }
        }
        .padding()
    }
}

struct TestAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimation()
    }
}
