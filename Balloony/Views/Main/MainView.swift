//
//  MainView.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct MainView: View {
    // MARK: - Properties
    @EnvironmentObject var balloonModelData: BalloonModelData
    @State var balloonYOffset: CGFloat = ScreenSize.height * 0.75
    @State var balloonXOffset: CGFloat = .zero
    @State var cardYOffset: CGFloat = ScreenSize.height * 0.95

    @State var heightTranslation: CGFloat = .zero

    var balloons: [Balloon] {
        balloonModelData.balloons
    }
    
    var selectedBalloon: Balloon {
        balloons[balloonModelData.selectedBalloonIdx]
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let newTranslationHeight = value.translation.height
                let amountChange = newTranslationHeight - heightTranslation
                heightTranslation = newTranslationHeight
                
                guard (amountChange < 0 && cardYOffset > 0) ||
                    (amountChange > 0 && cardYOffset <= ScreenSize.height * 0.3)
                else {
                    return
                }
                
                // print("amountChange: ", amountChange)
                withAnimation {
                    balloonYOffset += amountChange
                    cardYOffset += amountChange
                }
                            }
            .onEnded { _ in
                heightTranslation = .zero
            }
    }
    
    var dragBalloons: some Gesture {
        DragGesture()
            .onChanged { value in
                print("width trans: ", value.translation.width)
            }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Layer 1: Content
            ZStack{
                
                BalloonFrontView(
                    gradientColors: balloons[2].gradientColors,
                    size: balloons[2].frontViewSizeSmall
                )
                    .offset(
                        x: -80 - balloonXOffset,
                        y: -70 + balloonYOffset
                    )
                    .opacity(0.5)
                
                BalloonFrontView(
                    gradientColors: balloons[3].gradientColors,
                    size: balloons[3].frontViewSizeSmall
                )
                    .offset(
                        x: 80 + balloonXOffset,
                        y: -70 + balloonYOffset
                    )
                    .opacity(0.5)
                
                BalloonFrontView(
                    gradientColors: balloons[1].gradientColors,
                    size: balloons[1].frontViewSizeBig
                )
                    .offset(y: balloonYOffset)
                
            } //: ZStack
            .gesture(dragBalloons)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    balloonYOffset = ScreenSize.height * 0.2
                    balloonXOffset = 100
                    cardYOffset = ScreenSize.height * 0.3
                }
            }
                
            // MARK: - Layer 2: Cards
            VStack(spacing: 30) {
                
                ItemCardView(balloon: selectedBalloon)
                
                ReviewCardView()
                   
            } //: VStack
            .fillMaxSize()
            .zIndex(1)
            .padding(.horizontal, 21)
            .offset(y: cardYOffset)
            .gesture(drag)
            
            // MARK: Layer 3: Navigation Bar
            NavigationBarView()
                .zIndex(2)

        } //: ZStack
        .fillMaxSize(alignment: .top)
        .background(
            LinearGradient(
                colors: [
                    Colors.background.color,
                    Colors.background2.color,
                    Colors.background.color
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BalloonModelData())
    }
}
