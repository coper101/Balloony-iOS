//
//  ReviewCardView.swift
//  Balloony
//
//  Created by Wind Versi on 1/6/22.
//

import SwiftUI

struct ReviewCardView: View {
    // MARK: - Properties
    let horizontalPadding: CGFloat = 21

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Row 1: Header
            HStack(
                alignment: .center,
                spacing: 0
            ) {
                
                // Col 1: TITLE
                Text("Reviews")
                    .textStyle(
                        font: .quicksandSemiBold,
                        size: 20
                    )
                
                // Col 2:
                Spacer()
                
                // Col 3: STARS
                RatingBarView(ratingNum: 4)
                                
                
            } //: HStack
            .padding(.top, 20)
            .padding(.horizontal, horizontalPadding)
            
            // MARK: - Row 2:
            CardDividerView()
                .padding(.top, 6)
                .padding(.horizontal, horizontalPadding)
            
            // MARK: - Row 3: Customer Review & Comment
            VStack(spacing: 16) {
                
                Text("Delivery was quick and it came with a thank you note. Thanks.")
                    .textStyle(
                        size: 14,
                        maxWidth: .infinity,
                        alignment: .leading,
                        lineSpacing: 3
                    )
                
                HStack(spacing: 0) {
                    
                    // Col 1: Review Count
                    Text("1 / 100")
                        .textStyle(size: 12)
                        .opacity(0.5)
                    Spacer()
                    
                    // Col 2: Customer Stars
                    RatingBarView(
                        ratingNum: 5,
                        height: 15
                    )
                        .padding(.trailing, 14)
                    
                    // Col 3: Customer Name
                    Text("John Doe")
                        .textStyle(
                            font: .quicksandSemiBold,
                            size: 12
                        )
                        .opacity(0.5)
                    
                } //: HStack
                
            }
            .padding(.horizontal, horizontalPadding + 4)
            .padding(.top, 20)
           
            
            // MARK: - Row 4: All Reviews Button
            CardDividerView()
                .padding(.top, 12)
            
            Button(action: {}) {
                
                HStack(spacing: 3) {
                                    
                    // Col 1:
                    Text("SEE ALL")
                        .textStyle(size: 12)
                    
                    // Col 2
                    Icons.leftArrow.image
                        .resizable()
                        .foregroundColor(Colors.primary.color)
                        .frame(width: 17, height: 17)
                    
                } //: HStack
                .padding(.horizontal, 16)
                .fillMaxWidth(alignment: .trailing)
                .frame(height: 42)
                
            } //: Button
            
        }  //: VStack
        .backgroundBlur()
    }
}

// MARK: - Preview
struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background2.color)
    }
}
