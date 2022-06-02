//
//  BalloonTopView.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

struct BalloonTopView: View {
    // MARK: - Properties
    var gradientColors: [Colors]
    var length: CGFloat

    // MARK: - Body
    var body: some View {
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
                    Colors.primary.color.opacity(0.6),
                    Colors.primary.color.opacity(0)
                ],
                center: UnitPoint(x: 0.3, y: 0.3),
                startRadius: 1,
                endRadius: length * 0.7
            )
            
            
        } //: ZStack
        .frame(width: length, height: length)
        .clipShape(
            Circle()
        )
    }
}

// MARK: - Preview
struct BalloonTopView_Previews: PreviewProvider {
    static var balloons = BalloonModelData().balloons

    static var previews: some View {
        
        Group {
            ForEach(balloons, id: \.name) { balloon in
                BalloonTopView(
                    gradientColors: balloon.gradientColors,
                    length: balloon.topViewLength
                )
                    .previewDisplayName(balloon.name)
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Colors.background.color)
        
    }
}
