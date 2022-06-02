//
//  RatingBarView.swift
//  Balloony
//
//  Created by Wind Versi on 2/6/22.
//

import SwiftUI

struct RatingBarView: View {
    // MARK: - Properties
    var ratingNum: Int
    var height: CGFloat = 20

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            ForEach(1...5, id: \.self) { i in
                Icons.star.image
                    .resizable()
                    .foregroundColor(
                        Colors.primary.color.opacity(
                            i > ratingNum ? 0.2 : 1
                        )
                    )
                    .frame(width: height, height: height)
            }
            
        } //: HStack
    }
}

// MARK: - Preview
struct RatingBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            RatingBarView(ratingNum: 4)
                .previewDisplayName("4 Stars")
            
            RatingBarView(ratingNum: 5)
                .previewDisplayName("5 Stars")
            
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Colors.background.color)
        
    }
}
