//
//  BalloonFrontView.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

struct BalloonFrontView: View {
    // MARK: - Properties
    var gradientColors: [Colors]
    var size: (width: CGFloat, height: CGFloat)
    
    var balloon: some View {
        ZStack {
            
            // Layer 1: SOLID
            LinearGradient(
                colors: [
                    gradientColors[0].color,
                    gradientColors[1].color
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Layer 2: SHINE
            RadialGradient(
                colors: [
                    Colors.primary.color,
                    Colors.primary.color.opacity(0)
                ],
                center: UnitPoint(x: 0.3, y: 0.3),
                startRadius: 1,
                endRadius: size.height * 0.7
            )
            
            
        } //: ZStack
        .frame(
            width: size.width,
            height: size.height
        )
        .clipShape(
            Ellipse()
        )
    }
    
    var tie: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                path.move(
                    to: .init(
                        x: 0.15 * width,
                        y: 0.8 * height
                    )
                )
                
                // add line with corner radius
                path.addLine(
                    to: .init(
                        x: 0.4 * width,
                        y:  0.2 * height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: 0.6 * width,
                        y: 0.2 * height
                    ),
                    control: .init(
                        x: 0.5 * width,
                        y: 0
                    )
                )
                
                // add line with corner radius
                path.addLine(
                    to: .init(
                        x: 0.85 * width,
                        y: 0.8 * height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: 0.8 * width,
                        y: height
                    ),
                    control: .init(
                        x: 0.9 * width,
                        y: height
                    )
                )
                
                // add line with corner radius
                path.addLine(
                    to: .init(
                        x: 0.2 * width,
                        y: height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: 0.15 * width,
                        y: 0.8 * height
                    ),
                    control: .init(
                        x: 0.1 * width,
                        y: height
                    )
                )

            }
            .fill(gradientColors[1].color)
        }
        .frame(width: 20, height: 15)
    }
    
    var tieWithString: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let xSpace = 0.3
                let yStart = 0.35
                
                path.move(
                    to: .init(
                        x: xSpace * width,
                        y: yStart * height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: (1 - xSpace) * width,
                        y: yStart * height
                    ),
                    control: .init(
                        x: (xSpace + 0.3) * height,
                        y: (yStart + 0.1) * height
                    )
                )

            }
            .stroke(
                Colors.primary.color,
                style: .init(
                    lineWidth: 1.5,
                    lineCap: .round
                )
            )
        }
        .frame(width: 20, height: 15)
    }

    var string: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                path.move(
                    to: .init(
                        x: 0.5 * width,
                        y: .zero)
                )
                path.addLine(
                    to: .init(
                        x: 0.9 * width,
                        y: (0.25 - 0.1) * height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: 0.9 * width,
                        y: (0.25 + 0.1) * height
                    ),
                    control: .init(
                        x: width,
                        y: 0.25 * height
                    )
                )
                path.addLine(
                    to: .init(
                        x: 0.1 * width,
                        y: (0.75 - 0.1) * height
                    )
                )
                path.addQuadCurve(
                    to: .init(
                        x: 0.4 * width,
                        y: (0.75 + 0.1) * height
                    ),
                    control: .init(
                        x: .zero,
                        y: 0.75 * height
                    )
                )
                path.addLine(
                    to: .init(
                        x: width,
                        y: height
                    )
                )
            }
            .stroke(
                LinearGradient(
                    colors: [
                        Colors.primary.color.opacity(1),
                        Colors.primary.color.opacity(0.01)
                    ],
                    startPoint: .top,
                    endPoint: .init(x: 0.5, y: 0.8)
                ),
                style: .init(
                    lineWidth: 2,
                    lineCap: .round
                )
            )
        }
        .frame(width: 7, height: 96)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            balloon
            ZStack(alignment: .top) {
                string
                    .offset(y: 14)
                ZStack {
                    tie
                    tieWithString
                }
            }
            .offset(y: -5)
        }
    }
}

// MARK: - Preview
struct BalloonFrontView_Previews: PreviewProvider {
    static var balloons = BalloonModelData().balloons
    
    static var previews: some View {
        
        Group {
            ForEach(balloons, id: \.name) { balloon in
                BalloonFrontView(
                    gradientColors: balloon.gradientColors,
                    size: balloon.frontViewSizeBig
                )
                    .previewDisplayName(balloon.name)
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Colors.background.color)
        
    }
}
