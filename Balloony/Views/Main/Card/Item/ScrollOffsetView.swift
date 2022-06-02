//
//  ScrollOffsetView.swift
//  Balloony
//
//  Created by Wind Versi on 31/5/22.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ScrollOffsetView<Content: View>: View {
    // MARK: - Properties
    let axis: Axis.Set
    let showIndicators: Bool
    let content: () -> Content
    let onOffsetChange: (CGFloat) -> Void
    
    init(
        axis: Axis.Set = .vertical,
        showIndicators: Bool = true,
        onOffsetChange: @escaping (CGFloat) -> Void = {_ in},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.showIndicators = showIndicators
        self.content = content
        self.onOffsetChange = onOffsetChange
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(
            axis,
            showsIndicators: showIndicators
        ) {
            offsetReader
            // negative padding move to top to remove space of offsetReader
            content().padding(.top, -8)
        }
            .coordinateSpace(name: "frameLayer")
            .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("frameLayer")).minY
                )
        }
        .frame(height: 0)
    }
    
}

