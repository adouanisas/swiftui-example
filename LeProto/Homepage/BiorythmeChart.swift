//
//  BiorythmeChart.swift
//  LeProto
//
//  Created by Ahmed Adouani on 11/02/2023.
//

import SwiftUI
import Charts

struct CGPointWidthId: Identifiable {
    var id = UUID()
    var value: CGPoint
    var dot: Bool
    var bigDot: Bool
}

@available(iOS 16.0, *)
struct BiorythmeChart: View {
    
    var body: some View {
        GeometryReader { geoReader in
            let width = geoReader.size.width
            let height = geoReader.size.height
            
            let points = generatePoints(width: width, height: height)
            
            Chart(points) {
                if !$0.dot, !$0.bigDot {
                    LineMark(
                        x: .value("Mount", Double($0.value.x)),
                        y: .value("Value", Double($0.value.y))
                    )
                }
                if $0.dot {
                    PointMark(
                        x: .value("Mount", Double($0.value.x)),
                        y: .value("Value", Double($0.value.y))
                    ).foregroundStyle(.linearGradient(
                        colors: [.gray],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                }
                if $0.bigDot {
                    PointMark(
                        x: .value("Mount", Double($0.value.x)),
                        y: .value("Value", Double($0.value.y))
                    ).annotation(position: .overlay, alignment: .center) {
                        Image("dot")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        
                    }
                    .symbolSize(0) // hide the existing symbol
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 3)) { value in
                    if let axisValue = value as? AxisValue {
                        if axisValue.index == 1 {
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [3]))
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 3)) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [3]))
                }
            }
            .labelsHidden()
        }
        
    }
    
    private func generatePoints(width: CGFloat, height: CGFloat) -> [CGPointWidthId] {
        
        
        var points = [CGPointWidthId]()
        
        let step = width/23.0
        //4/23
        
        // 19 => PI
        
        for x in stride(from: 0, through: step*23, by: 5.0) {
            let angle = 2*Double.pi * (x+3*step)/width
            let y = 1 - CGFloat(sin(angle))
            
            points.append(CGPointWidthId(value: CGPoint(x: x, y: y), dot: false, bigDot: false))
            
        }
        
        for index in stride(from: 0, through: 23, by: 1) {
            let x = CGFloat(index)*step
            let angle = 2*Double.pi * (x+3*step)/width
            let y = 1 - CGFloat(sin(angle))
            if index == 10 {
                points.append(CGPointWidthId(value: CGPoint(x: x, y: y), dot: false, bigDot: true))
            } else {
                points.append(CGPointWidthId(value: CGPoint(x: x, y: y), dot: true, bigDot: false))
            }
            
        }
        
        
        return points
    }
}

struct BiorythmeChart_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            BiorythmeChart().frame(width: 280*UIConstants.scalingFactor, height: 200*UIConstants.scalingFactor)
        } else {
            // Fallback on earlier versions
        }
    }
}
