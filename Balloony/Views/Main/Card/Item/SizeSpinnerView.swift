//
//  SizeSpinnerView.swift
//  Balloony
//
//  Created by Wind Versi on 27/5/22.
//

import SwiftUI

struct SizeSpinnerView: View {
    // MARK: - Properties
    @State var contentOffset: CGPoint = .zero
    @State var offsetToScroll: CGPoint = .zero
    @State var selectedSize: Sizes = .fiveInch
    
    let height: CGFloat = 100
    
    var spinnerGradient: LinearGradient {
        LinearGradient(
            colors: [
                Colors.primary.color.opacity(0.05),
                Colors.primary.color,
                Colors.primary.color.opacity(0.05)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var spinner: some View {
        GeometryReader { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            let blockHeight = height / 3
            
                    
            LegacyScrollView(
                showsIndicators: false,
                offsetToScroll: offsetToScroll,
                onEndedScrolling: onEndedScrolling,
                onEndedDragging: {},
                contentOffset: $contentOffset,
                isScrollDisabled: false
            ) {
                
                VStack(spacing: 0) {

                    // SPACER
                    Rectangle()
                        .fill(Color.clear)
                        .fillMaxWidth()
                        .frame(height: blockHeight)
                        .id(0)
                    
                    // SIZES
                    ForEach(Sizes.allCases) { size in
                        Text("\(size.id) inch")
                            .textStyle(
                                font: .quicksandSemiBold,
                                size: 16
                            )
                            .id(size.rawValue)
                            .fillMaxWidth()
                            .frame(height: blockHeight)
                    }

                    // SPACER
                    Rectangle()
                        .fill(Color.clear)
                        .fillMaxWidth()
                        .frame(height: blockHeight)
                        .id(100)
                    
                } //: VStack
                .frame(width: width)
                        
                    
            } //: LegacyScrollView
            .frame(width: width)
            .mask(spinnerGradient)
            .onChange(of: offsetToScroll) { offset in
                switch offset.y {
                case .zero:
                    selectedSize = .fiveInch
                case blockHeight:
                    selectedSize = .nineInch
                default:
                    selectedSize = .elevenInch
                }
            }
            
        } //: GeometryReader
        .frame(width: 50, height: height)
    }
    

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            // Col 1: POINTER
            Icons.pointer.image
                .resizable()
                .foregroundColor(Colors.primary.color.opacity(0.2))
                .frame(width: 50, height: 50)
            
            // Col 2: SPINNER
            spinner
            
        } //: HStack
    }
    
    // MARK: - Functions
    func onEndedScrolling() {
        let blockHeight: CGFloat = height / 3
                        
        if contentOffset.y <= 0.5 * blockHeight {
            offsetToScroll.y = .zero
        } else if contentOffset.y <= 1.5 * blockHeight {
            offsetToScroll.y = blockHeight
        } else {
            offsetToScroll.y = blockHeight * 2
        }
    }
}

// MARK: - Preview
struct SizeSpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SizeSpinnerView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
        
    }
}
