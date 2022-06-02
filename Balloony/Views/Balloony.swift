//
//  Balloony.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

enum ScreenContent {
    case splash
    case main
}

struct Balloony: View {
    // MARK: - Properties
    @State private var content: ScreenContent = .splash

    // MARK: - Body
    var body: some View {
        ZStack {
            
            // Layer content for smoother transition
            // Layer 1: SPLASH
            SplashView(content: $content)
            
            // Layer 2: MAIN
            if content == .main {
                MainView()
                    .transition(
                        .opacity.animation(
                            .easeOut(duration: 0.5)
                        )
                    )
            } //: if
            
        } //: ZStack
    }
}

// MARK: - Preview
struct Balloony_Previews: PreviewProvider {
    static var previews: some View {
        Balloony()
    }
}
