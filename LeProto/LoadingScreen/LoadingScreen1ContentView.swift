//
//  LoadingScreen1.swift
//  LeProto
//
//  Created by Ahmed Adouani on 18/01/2023.
//

import SwiftUI

struct LoadingScreen1ContentView: View {
    
    let automaticTransition: Bool
    
    @State private var mainTextOpacity: CGFloat = 0
    
    @State private var mainTextOpacityAnimationDone = false
    
    init(automaticTransition: Bool = true) {
        self.automaticTransition = automaticTransition
    }
    
    var body: some View {
        ZStack {
            Color
                .black.ignoresSafeArea()
            
            if mainTextOpacityAnimationDone {
                GeometryReader { geometry in
                    BackgroundContentView(geometry.size.height, automaticTransition: automaticTransition)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            } else {
                GeometryReader { geometry in
                    BackgroundContentView(geometry.size.height, automaticTransition: false, animated: false)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
            VStack(spacing: 0) {
                Text("Nous préparons \nton rapport quotidien...")
                    .appFontH1()
                    .opacity(mainTextOpacity)
                    .foregroundColor(.white)
                    .frame(height: 74*UIConstants.scalingFactor)
                    .multilineTextAlignment(.center)
                    .onAnimationCompleted(for: mainTextOpacity, completion: {
                        mainTextOpacityAnimationDone = true
                    })
                    .onAppear {
                        withAnimation(Animation.spring().speed(0.2)) {
                                        mainTextOpacity = 1
                                    }
                    }
                    
            }
            .preferredColorScheme(.dark)
            //.padding()
        }
    }
}

struct BackgroundContentView: View {
    
    let automaticTransition: Bool
    
    @State private var offset: CGFloat = 0.0
    @State private var backgroundScale: CGFloat = 1.0
    
    @EnvironmentObject var opData: OpData
    
    private let height: CGFloat
    
    private let animated: Bool
    
    init(_ height: CGFloat, automaticTransition: Bool, animated: Bool = true) {
        self.height = height
        self.animated = animated
        self.automaticTransition = automaticTransition
    }
    
    private var timeCurveAnimation: Animation {
        return Animation.easeInOut(duration: 2.5).delay(0.5)
    }
    
    var body: some View {
        Image("LoadingScreen01_bg")
            .transition(.scale(scale: 2))
            .offset(CGSize(width: 0, height: offset))
            .onAnimationCompleted(for: offset) {
                if automaticTransition {
                    opData.currentView = .loading2
                }
            }
            .zIndex(0)
            .scaleEffect(backgroundScale)
            .onAppear {
                if animated {
                    withAnimation(self.timeCurveAnimation) {
                        self.offset = height*1.2
                        self.backgroundScale = backgroundScale*2
                    }
                }
            }.edgesIgnoringSafeArea(.all)
    }
}

struct LoadingScreen1_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen1ContentView(automaticTransition: false)
    }
}

extension View {
    
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}

/// An animatable modifier that is used for observing animations for a given animatable value.
struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }
    
    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value
    
    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void
    
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        
        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }
    
    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}
