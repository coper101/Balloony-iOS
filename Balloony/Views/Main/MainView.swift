//
//  MainView.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - Properties
    @EnvironmentObject private var balloonModelData: BalloonModelData
    @State private var balloonYOffset: CGFloat = ScreenSize.height * 0.7
    @State private var balloonXOffset: CGFloat = -146
    @State private var cardYOffset: CGFloat = ScreenSize.height * 0.95
    @State var heightTranslation: CGFloat = .zero
    
    let balloonYMaxOffset = UICompSize.navBarHeight + Insets.top.value + 50
    var cardYMaxOffset: CGFloat {
        balloonYMaxOffset + UICompSize.balloonListHeight - 50
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let newTranslationHeight = value.translation.height
                let amountChange = newTranslationHeight - heightTranslation
                heightTranslation = newTranslationHeight
                
                let moreThanMin = amountChange < 0 && cardYOffset > ScreenSize.height * 0.2
                let lessThanMax = amountChange > 0 && cardYOffset <= cardYMaxOffset
                
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
                    balloons: balloonModelData.balloons
                )
                    .offset(y: balloonYOffset)
                
            } //: ZStack
            .frame(width: ScreenSize.width)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    balloonYOffset = balloonYMaxOffset
                    balloonXOffset = 10
                    cardYOffset = cardYMaxOffset
                }
            }
                
            // MARK: - Layer 2: Cards
            VStack(spacing: 30) {
                
                // Row 1: BALLOON DESC CARD
                ItemCardView(
                    balloon: balloonModelData.selectedBalloon,
                    selectedSize: $balloonModelData.selectedSize,
                    quantity: $balloonModelData.quantity,
                    totalPrice: balloonModelData.totalPrice
                )
                
                // Row 2: BALLOON REVIEWS
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
                .padding(.top, Insets.top.value)

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
