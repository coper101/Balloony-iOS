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
    @State private var selectedSize: Sizes = .nineInch
    @State private var quantity = "1"

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
                    .padding(.top, 15)
                Spacer()
                
                // Col 2: SALE BANNER
                SaleBannerView()
                
            } //: HStack
            
            // MARK: - Row 2:
            CardDividerView()
            
            // MARK: - Row 3:
            HStack(alignment: .center, spacing: 0) {
                
                // Col 1: SIZE SPINNER
                SizeSpinnerView()
                
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
                        Text("BUY $8.50")
                            .textStyle(
                                foregroundColor: .background,
                                font: .quicksandSemiBold,
                                size: 16
                            )
                    }
                    .padding(.horizontal, 25)
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
        
        ItemCardView(balloon: balloons[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background2.color)
            .previewDisplayName("Item Card")
        
    }
}
