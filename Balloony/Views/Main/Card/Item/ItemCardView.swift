//
//  ItemCardView.swift
//  Balloony
//
//  Created by Wind Versi on 27/5/22.
//

import SwiftUI

enum Sizes: Int, CaseIterable, Identifiable {
    case fiveInch = 5
    case nineInch = 9
    case elevenInch = 11
    var id: String {
        "\(self.rawValue)"
    }
}

struct ItemCardView: View {
    // MARK: - Properties
    var balloon: Balloon
    @Binding var selectedSize: Sizes
    @Binding var quantity: String
    var totalPrice: Double

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Row 1:
            HStack(spacing: 0) {
                
                // Col 1: NAME
                Text(balloon.name)
                    .textStyle(
                        font: .quicksandSemiBold,
                        size: 25
                    )
                    .fillMaxWidth(alignment: .leading)
                    .padding(.top, 15)
                    .id(balloon.name) // for animation to work
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                
                // Col 2: SALE BANNER
                SaleBannerView()
                
            } //: HStack
            
            // MARK: - Row 2:
            CardDividerView()
            
            // MARK: - Row 3:
            HStack(alignment: .center, spacing: 0) {
                
                // Col 1: SIZE SPINNER
                SizeSpinnerView(selectedSize: $selectedSize)
                Spacer()
                
                // Col 2: FEATURES
                VStack(alignment: .leading, spacing: 4) {
                    
                    ForEach(balloon.features, id: \.title) {
                        FeatureRowView(feature: $0)
                    }
                    
                } //: VStack
                
            }
            .padding(.top, 10)
            .padding(.horizontal, 0)
            .frame(height: 100, alignment: .center)
            
            // MARK: - Row 4:
            HStack(spacing: 0) {
                
                // Col 1: STEPPER QUANTITY
                StepperQuantityView(quantity: $quantity)
                    .padding(.bottom, 2)

                Spacer()
                                    
                // Col 2: BUY BUTTON
                Button(action: {}) {
                    
                    ZStack {
                        Text("BUY $\(totalPrice.roundTo2Dp())")
                            .textStyle(
                                foregroundColor: .background,
                                font: .quicksandSemiBold,
                                size: 16
                            )
                    }
                    .padding(.horizontal, 21)
                    .frame(height: 35)
                    .background(Colors.secondary.color)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    
                } //: Button
                
            } //: HStack
            .padding(.top, 24)
            .padding(.bottom, 14)

        } //: VStack
        .fillMaxWidth()
        .padding(.horizontal, 20)
        .backgroundBlur()
    }
}

// MARK: - Preview
struct ItemCardView_Previews: PreviewProvider {
    static var balloons = BalloonModelData().balloons

    static var previews: some View {
        ItemCardView(
            balloon: balloons[0],
            selectedSize: .constant(.fiveInch),
            quantity: .constant("1"),
            totalPrice: balloons[0].price
        )
            .previewLayout(.sizeThatFits)
            .padding(21)
            .background(Colors.background2.color)
    }
}
