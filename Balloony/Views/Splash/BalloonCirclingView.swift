//
//  BalloonCirclingView.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

struct BalloonCirclingView: View {
    // MARK: - Properties
    @EnvironmentObject private var balloonModelData: BalloonModelData
    let dotLength: CGFloat = 10
    let spaceLength: CGFloat = 10
    
    var balloons: [Balloon] {
        balloonModelData.balloons
    }

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Layer 1: DOTTED STRINGS
            ZStack(alignment: .bottom) {
                
                Circle()
                    .stroke(
                        Colors.primary.color.opacity(0.2),
                        style: .init(
                            lineWidth: 1,
                            dash: [dotLength, spaceLength]
                        )
                    )
                    .frame(width: 492, height: 492)
                
                Circle()
                    .stroke(
                        Colors.primary.color.opacity(0.2),
                        style: .init(
                            lineWidth: 1,
                            dash: [dotLength, spaceLength]
                        )
                    )
                    .frame(width: 343, height: 343)
                    .offset(x: -10, y: 10)
            }
            .rotationEffect(.init(degrees: 300))
            
            // Layer 2: Balloons
            BalloonTopView(
                gradientColors: balloons[4].gradientColors,
                length: balloons[4].topViewLength
            )
                .offset(x: -170, y: -380)
            
            BalloonTopView(
                gradientColors: balloons[1].gradientColors,
                length: balloons[1].topViewLength
            )
                .offset(x: -240, y: -110)
            
            BalloonTopView(
                gradientColors: balloons[3].gradientColors,
                length: balloons[3].topViewLength
            )
                .offset(x: -30, y: -470)
            
            BalloonTopView(
                gradientColors: balloons[0].gradientColors,
                length: balloons[0].topViewLength
            )
                .offset(x: 140, y: -410)
            
            BalloonTopView(
                gradientColors: balloons[2].gradientColors,
                length: balloons[2].topViewLength
            )
                .offset(x: -20, y: -280)
            
        }
        .frame(width: 662, height: 573)
        
    }
}

// MARK: - Preview
struct BalloonCirclingView_Previews: PreviewProvider {
    static var previews: some View {
        
        BalloonCirclingView()
            .environmentObject(BalloonModelData())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
            .previewDisplayName("Birds Eye View of Balloons Circling")
        
    }
}
