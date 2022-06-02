//
//  CardDividerView.swift
//  Balloony
//
//  Created by Wind Versi on 1/6/22.
//

import SwiftUI

struct CardDividerView: View {
    var body: some View {
        Rectangle()
            .fill(Colors.primary.color.opacity(0.1))
            .fillMaxWidth()
            .padding(.horizontal, 5)
            .frame(height: 0.5)
            .padding(.top, 10)
    }
}

struct CardDividerView_Previews: PreviewProvider {
    static var previews: some View {
        CardDividerView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background2.color)
    }
}
