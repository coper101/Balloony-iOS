//
//  ModelData.swift
//  Balloony
//
//  Created by Wind Versi on 26/5/22.
//

import SwiftUI

class BalloonModelData: ObservableObject {
    
    @Published var selectedBalloonIdx = 0
    
    @Published var balloons: [Balloon] = [
        .init(
            name: "Cosmic",
            gradientColors: [
                .combination5a,
                .combination5b
            ],
            topViewLength: 94
        ),
        .init(
            name: "Saturn",
            gradientColors: [
                .combination4a,
                .combination4b
            ],
            topViewLength: 201
        ),
        .init(
            name: "Aqua",
            gradientColors: [
                .combination2a,
                .combination2b
            ],
            topViewLength: 115
        ),
        .init(
            name: "Sun",
            gradientColors: [
                .combination3a,
                .combination3b
            ],
            topViewLength: 48
        ),
        .init(
            name: "Unicorn",
            gradientColors: [
                .combination1a,
                .combination1b
            ],
            topViewLength: 86
        )
    ]
}
