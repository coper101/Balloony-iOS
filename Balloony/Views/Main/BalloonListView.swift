//
//  BalloonListView.swift
//  Balloony
//
//  Created by Wind Versi on 1/6/22.
//

import SwiftUI

struct BalloonListView: View {
    // MARK: - Properties
    @State private var widthTranslation: CGFloat = .zero
    @State private var listYOffset: CGFloat = .zero
    @Binding var selectedIndex: Int
    
    var xOffsetAnimation: CGFloat
    var balloons: [Balloon]
    
    let blockWidth: CGFloat = 146 + 40
    
    var size: Int {
        balloons.count
    }
    
    var isSizeEven: Bool {
        size % 2 == 0
    }
    
    var maxYOffset: CGFloat {
        // when no. of items is even, we add an invisible
        // space to determine the center
        let adjustedSize = size + (isSizeEven ? 1 : 0)
        var max = -CGFloat((adjustedSize - 1) / 2) * blockWidth
        if isSizeEven {
            max += blockWidth
        }
        return max
    }
    
    var centerIndex: Int {
        return !isSizeEven ?
            ((size - 1) / 2) + 1 :
            (size / 2) + 1
    }
    
    func getXOffset(_ i: Int) -> CGFloat {
        if i == (centerIndex - 1) {
            return -xOffsetAnimation
        } else if i == (centerIndex + 1) {
            return xOffsetAnimation
        }
        return 0
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                let newWidthTranslation = value.translation.width
                let amountChange = newWidthTranslation - widthTranslation
                widthTranslation = newWidthTranslation
                let newListYOffset = listYOffset + amountChange
                
                // restrict from scrolling more (end of list)
                let minYOffset = abs(maxYOffset)
                let scrollRange = maxYOffset...minYOffset
                guard scrollRange.contains(newListYOffset) else {
                    return
                }
                // move to new position
                listYOffset = newListYOffset
            }
            .onEnded { _ in
                // reset
                widthTranslation = .zero
            }
    }

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            ForEach(1...size, id: \.self) { i in
                
                let balloon = balloons[i - 1]
                
                // the range for item to be on focus (big size)
                let yOffsetToFocus = calcYOffsetToFocus(i, centerIndex)
                let isFocused = yOffsetToFocus.contains(listYOffset)
                let size = isFocused ?
                    balloon.frontViewSizeBig : balloon.frontViewSizeSmall
                let opacity = isFocused ? 1 : 0.5
                                
                BalloonFrontView(
                    gradientColors: balloon.gradientColors,
                    size: size
                )
                    .frame(width: blockWidth, alignment: .center)
                    .background(Color.clear)
                    .opacity(opacity)
                    .offset(
                        x: getXOffset(i),
                        y: isFocused ? 0 : -70
                    )
                    .animation(.easeInOut(duration: 0.6), value: listYOffset)
                
                // add invisible item to make items size odd
                // always centers 3 items on screen
                if isSizeEven && i == self.size {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(
                            width: balloon.frontViewSizeSmall.width,
                            height: balloon.frontViewSizeSmall.height
                        )
                }
                
            }
            
        }
        .offset(x: listYOffset)
        .gesture(drag)
    }
    
    // MARK: - Functions
    func calcYOffsetToFocus(
        _ index: Int,
        _ centerIndex: Int
    ) -> ClosedRange<CGFloat> {
        let mid = (index == centerIndex) ?
            0 : CGFloat(centerIndex - index) * blockWidth
        let halfBlock = blockWidth * 0.5
        let a = (mid + halfBlock) - 1
        let b = mid - halfBlock
        let range = (a > b) ? b...a : a...b
        
//        print("""
//                blockWidth: \(blockWidth)
//                index: \(index)
//                centerIndex: \(centerIndex)
//                mid: \(mid)
//                range: \(range)
//
//                """)
        
        return range
    }
    
}

// MARK: - Preview
struct BalloonListView_Previews: PreviewProvider {
    static var previews: some View {
        BalloonListView(
            selectedIndex: .constant(0),
            xOffsetAnimation: 0,
            balloons: BalloonModelData().balloons
        )
            .previewLayout(.fixed(width: ScreenSize.width, height: 340))
            .padding(.top, 70)
            .background(Colors.background2.color)
    }
}
