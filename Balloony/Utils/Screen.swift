//
//  Screen.swift
//  Balloony
//
//  Created by Wind Versi on 4/6/22.
//

import SwiftUI

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct UICompSize {
    static let navBarHeight: CGFloat = 60
    static let balloonListHeight: CGFloat = 300
}

enum Insets {
    case top
    case bottom
    var value: CGFloat {
        guard let window = UIApplication.shared.windows.first else {
            return 0
        }
        let safeAreaInsets = window.safeAreaInsets
        switch self {
        case .top:
            return safeAreaInsets.top
        case .bottom:
            return safeAreaInsets.bottom
        }
    }
    
}
