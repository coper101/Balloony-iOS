//
//  Balloons.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

struct Feature {
    let title: String
    let iconName: String
}

struct Balloon {
    typealias Size = (width: CGFloat, height: CGFloat)
    let name: String
    let gradientColors: [Colors]
    var topViewLength: CGFloat
    let frontViewSizeSmall: Size = (109, 132)
    let frontViewSizeBig: Size = (146, 177)
    var features: [Feature] = [
        .init(
            title: "Long-lasting",
            iconName: "Thunderbolt"
        ),
        .init(
            title: "Helium Inflated",
            iconName: "Spaceship"
        ),
        .init(
            title: "Strings Included",
            iconName: "String"
        )
    ]
}
