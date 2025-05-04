//
//  CustomSegmentedControl.swift
//  LeProto
//
//  Created by Ahmed Adouani on 21/01/2023.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    
    static var defaultValue = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct CustomSegmentedControl: View {
    
    private var titles = ["Amour", "Carrière", "Amitié"]
    
    @State var selectedIndex: Int = 0
    @State var currentSelectedIndex: Int = 0
    
    var body: some View {
        
        SegmentedControlView(selectedIndex: $selectedIndex, currentSelectedIndex: $currentSelectedIndex, titles: titles)
            .animationObserver(for: Float(selectedIndex)) { progress in
                let delta =  abs(progress - Float(currentSelectedIndex))
                if delta > 0.5 {
                    currentSelectedIndex = selectedIndex
                }
            } onComplete: {
                currentSelectedIndex = selectedIndex
            }
            .animation(.spring(), value: selectedIndex)
            .animation(.spring(), value: currentSelectedIndex)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 2)
            )
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.clear)
                    .shadow(color: .black, radius: 0, x: 3, y: 3)
            )
        
    }
}


struct SegmentedControlView: View {
    @Binding private var selectedIndex: Int
    @Binding private var currentSelectedIndex: Int
    
    @State private var frames: Array<CGRect>
    @State private var backgroundFrame = CGRect.zero
    
    private let titles: [String]
    
    init(selectedIndex: Binding<Int>, currentSelectedIndex: Binding<Int>, titles: [String]) {
        self._selectedIndex = selectedIndex
        self._currentSelectedIndex = currentSelectedIndex
        self.titles = titles
        frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SegmentedControlButtonView(selectedIndex: $selectedIndex, currentSelectedIndex: $currentSelectedIndex, frames: $frames, backgroundFrame: $backgroundFrame, titles: titles)
        }
        .background(
            GeometryReader { geoReader in
                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                    .onPreferenceChange(RectPreferenceKey.self) {
                        self.setBackgroundFrame(frame: $0)
                    }
            }
        )
    }
    
    private func setBackgroundFrame(frame: CGRect)
    {
        backgroundFrame = frame
    }
}

private struct SegmentedControlButtonView: View {
    @Binding private var selectedIndex: Int
    @Binding private var frames: [CGRect]
    @Binding private var backgroundFrame: CGRect
    
    @Binding private var currentSelectedIndex: Int
    
    private let titles: [String]
    
    init(selectedIndex: Binding<Int>, currentSelectedIndex: Binding<Int>, frames: Binding<[CGRect]>, backgroundFrame: Binding<CGRect>, titles: [String])
    {
        _selectedIndex = selectedIndex
        _frames = frames
        _backgroundFrame = backgroundFrame
        _currentSelectedIndex = currentSelectedIndex
        self.titles = titles
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                Button(action:{ selectedIndex = index })
                {
                    HStack {
                        Text(titles[index])
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(selectedIndex == index ? .white : .black)
                    }
                }
                .buttonStyle(CustomSegmentButtonStyle(isLeftest: index == 0, isRightest: index == titles.count-1))
                .background(
                    GeometryReader { geoReader in
                        Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                            .onPreferenceChange(RectPreferenceKey.self) {
                                self.setFrame(index: index, frame: $0)
                            }
                    }
                )
                if index != titles.count-1 {
                    if #available(iOS 15.0, *) {
                        Divider().frame(minWidth: 3)
                            .overlay(.black)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .modifier(UnderlineModifier(isLeftest: currentSelectedIndex == 0, isRightest: currentSelectedIndex == titles.count-1, selectedIndex: selectedIndex, currentSelectedIndex: currentSelectedIndex, frames: frames))
    }
    
    private func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

private struct CustomSegmentButtonStyle: ButtonStyle {
    
    let isLeftest: Bool
    let isRightest: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(
                myBackground(color: (configuration.isPressed ? Color.gray : Color.clear))
            )
    }
    
    private func myBackground(color: Color) -> some View {
        if isLeftest {
            return RoundedCorners(color: color, tl: 15, tr: 0, bl: 15, br: 0)
        } else if isRightest {
            return RoundedCorners(color: color, tl: 0, tr: 15, bl: 0, br: 15)
        } else {
            return RoundedCorners(color: color, tl: 0, tr: 0, bl: 0, br: 0)
        }
    }
}


/// This modifier provides an animated underscore for the SegmentedControl.
struct UnderlineModifier: ViewModifier
{
    
    let isLeftest: Bool
    let isRightest: Bool
    
    private func myBackground(color: Color) -> some View {
        if isLeftest {
            return RoundedCorners(color: color, tl: 15, tr: 0, bl: 15, br: 0)
        } else if isRightest {
            return RoundedCorners(color: color, tl: 0, tr: 15, bl: 0, br: 15)
        } else {
            return RoundedCorners(color: color, tl: 0, tr: 0, bl: 0, br: 0)
        }
    }
    
    var selectedIndex: Int
    var currentSelectedIndex: Int
    
    let frames: [CGRect]
    
    func body(content: Content) -> some View
    {
        content
            .background(
                myBackground(color: Color.black)
                    .frame(width: frames[currentSelectedIndex].width)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX)
                , alignment: .bottomLeading
            )
    }
}

struct CustomSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            CustomSegmentedControl()
        }.padding(.horizontal, UIConstants.screenHorizontalPadding)
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {
    // this is the view property that drives the animation - offset, opacity, etc.
    private let observedValue: Value
    private let onChange: ((Value) -> Void)?
    private let onComplete: (() -> Void)?
    
    // SwiftUI implicity sets this value as the animation progresses
    public var animatableData: Value {
        didSet {
            notifyProgress()
        }
    }
    
    public init(for observedValue: Value,
                onChange: ((Value) -> Void)?,
                onComplete: (() -> Void)?) {
        self.observedValue = observedValue
        self.onChange = onChange
        self.onComplete = onComplete
        animatableData = observedValue
    }
    
    public func body(content: Content) -> some View {
        content
    }
    
    private func notifyProgress() {
        DispatchQueue.main.async {
            onChange?(animatableData)
            if animatableData == observedValue {
                onComplete?()
            }
        }
    }
}

extension View {
    func animationObserver<Value: VectorArithmetic>(
        for value: Value,
        onChange: ((Value) -> Void)? = nil,
        onComplete: (() -> Void)? = nil) -> some View {
            self.modifier(AnimationObserverModifier(
                for: value,
                onChange: onChange,
                onComplete: onComplete))
    }
}

