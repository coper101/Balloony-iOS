//
//  SplashView.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Properties
    @Binding var content: ScreenContent
    @State var xOffset: CGFloat = .zero

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            
            VStack(
                alignment: .leading,
                spacing: 10
            ) {

                // Row 1:
                if #available(iOS 15.0, *) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Colors.combination4b.color,
                                    Colors.combination4a.color,
                                    Colors.combination5b.color,
                                    Colors.combination1b.color,
                                    Colors.combination1a.color,
                                    Colors.combination5a.color,
                                    Colors.combination2a.color
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 1771, height: 74)
                        .offset(x: xOffset)
                        .mask {
                            Text("Balloony")
                                .textStyle(
                                    foregroundColor: .primary,
                                    font: .quicksandSemiBold,
                                    size: 62
                                )
                                .fillMaxSize(alignment: .leading)
                        }
                } else {
                    // Fallback on earlier versions
                }

                // Row 2:
                Text("Gradient Colored Balloons")
                    .kerning(2)
                    .textStyle(
                        foregroundColor: .primary,
                        font: .quicksandMedium,
                        size: 16
                    )
                    .padding(.leading, 12)

                Spacer()
                
                // Row 3:
                BalloonCirclingView()
                    .offset(x: -100, y: 200)


            } //: VStack
            .padding(.leading, 34)
            .padding(.top, geometry.size.height * 0.2)

        } //: GeometryReader
        .fillMaxSize(alignment: .leading)
        .background(
            LinearGradient(
                colors: [
                    Colors.background.color,
                    Colors.background2.color
                ],
                startPoint: .topTrailing,
                endPoint: .init(x: 0, y: 1.2)
            )
        )
        .onAppear {
            withAnimation(
                .easeOut(duration: 1.5)
                    .repeatCount(4, autoreverses: true)
            ) {
                xOffset = -900
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 * 3) {
                    withAnimation {
                        content = .main
                    }
                }
            }
        }
        
    }
}

// MARK: - Preview
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        
        SplashView(content: .constant(.splash))
            .previewLayout(.device)

    }
}
