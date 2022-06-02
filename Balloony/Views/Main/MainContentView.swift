//
//  MainContentView.swift
//  Balloony
//
//  Created by Wind Versi on 1/6/22.
//

import SwiftUI

struct MainContentView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Preview
struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background2.color)
    }
}
