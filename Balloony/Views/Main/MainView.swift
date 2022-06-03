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
    @State var balloonYOffset: CGFloat = ScreenSize.height * 0.7
    @State var balloonXOffset: CGFloat = -146
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
                
                let moreThanMin = amountChange < 0 && cardYOffset > ScreenSize.height * 0.2
                let lessThanMax = amountChange > 0 && cardYOffset <= ScreenSize.height * 0.44
                
                guard moreThanMin || lessThanMax else {
                    return
                }
                
                // move to new position
                withAnimation {
                    balloonYOffset += amountChange
                    cardYOffset += amountChange
                }
                            }
            .onEnded { _ in
                // reset
                heightTranslation = .zero
            }
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Layer 1: Balloons
            ZStack {
                
                BalloonListView(
                    selectedIndex: $balloonModelData.selectedBalloonIdx,
                    xOffsetAnimation: balloonXOffset,
                    balloons: balloons
                )
                    .offset(y: balloonYOffset)
                
            } //: ZStack
            .frame(width: ScreenSize.width)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    balloonYOffset = ScreenSize.height * 0.16
                    balloonXOffset = 10
                    cardYOffset = ScreenSize.height * 0.45
                }
            }
                
            // MARK: - Layer 2: Cards
            VStack(spacing: 30) {
                
                ItemCardView(balloon: selectedBalloon)
                
                ReviewCardView()
                   
            } //: VStack
            .fillMaxWidth()
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
        
    } //: ZStack
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(BalloonModelData())
    }
}
