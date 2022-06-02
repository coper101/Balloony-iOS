//
//  FeatureRowView.swift
//  Balloony
//
//  Created by Wind Versi on 27/5/22.
//

import SwiftUI

struct FeatureRowView: View {
    // MARK: - Properties
    var feature: Feature
    
    var body: some View {
        HStack(spacing: 9) {
            
            // Col 1: ICON
            Image(feature.iconName)
                .resizable()
                .foregroundColor(Colors.primary.color)
                .frame(width: 24, height: 24, alignment: .center)
            
            // Col 2: TITLE
            Text(feature.title)
                .textStyle(size: 12)
            
        } //: HStack
    }
}

struct FeatureRow_Previews: PreviewProvider {
    static var features = BalloonModelData().balloons[0].features
    
    static var previews: some View {
        
        ForEach(features, id: \.title) { feature in
            FeatureRowView(feature: feature)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Colors.background.color)
                .previewDisplayName(feature.title)
        }
    }
}
