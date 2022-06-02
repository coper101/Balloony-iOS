//
//  SaleBannerView.swift
//  Balloony
//
//  Created by Wind Versi on 27/5/22.
//

import SwiftUI

struct SaleBannerView: View {
    // MARK: - Properties
    var title: String = "10% OFF"
    
    var banner: some View {
        GeometryReader { geometry in
            
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                path.move(to: .zero)
                path.addLine(to: .init(x: width, y: .zero))
                path.addLine(to: .init(x: width, y: height))
                path.addLine(to: .init(x: width * 0.5, y: 0.8 * height))
                path.addLine(to: .init(x: .zero, y: height))
                path.addLine(to: .zero)
            }
            .fill(Color.red)
            
        } //: GeometryReader
        .overlay(
            LinearGradient(
                colors: [
                    Colors.primary.color.opacity(0.2),
                    Colors.primary.color.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
                .padding(.bottom, 20)
        )
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer 1:
            banner
            
            // Layer 2
            Text(title)
                .textStyle(
                    font: .quicksandSemiBold,
                    size: 13,
                    maxWidth: .infinity,
                    alignment: .center
                )
                .padding(.bottom, 13)
                .padding(.leading, 3)
            
        } //: ZStack
        .frame(width: 43, height: 54)
    }
}

struct SaleBannerView_Previews: PreviewProvider {
    static var previews: some View {
        SaleBannerView()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Sale Banner")
            .padding()
            .background(Colors.background.color)
    }
}
