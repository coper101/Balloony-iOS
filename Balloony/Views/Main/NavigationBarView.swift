//
//  NavigationBarView.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        HStack(spacing: 0) {
            
            // Col 1: Menu
            Button(action: {}) {
                Icons.menu.image
                    .resizable()
                    .foregroundColor(Colors.primary.color)
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            }
            Spacer()
            
            // Col 2: App Name
            Text("Balloony")
                .textStyle(
                    foregroundColor: .primary,
                    font: .quicksandMedium,
                    size: 30
                )
            Spacer()
            
            // Col 3: Search
            Button(action: {}) {
                Icons.search.image
                    .resizable()
                    .foregroundColor(Colors.primary.color)
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            }
            
        } //: HStack
        .fillMaxWidth()
        .frame(height: UICompSize.navBarHeight)
    }
}

// MARK: - Preview
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Navigation Bar")
            .background(Colors.background.color)
        
    }
}

