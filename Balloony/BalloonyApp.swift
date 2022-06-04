//
//  BalloonyApp.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

@main
struct BalloonyApp: App {
    @StateObject var balloonModelData = BalloonModelData()
    
    var body: some Scene {
        WindowGroup {
             Balloony()
                 .environmentObject(balloonModelData)
                 .edgesIgnoringSafeArea(.all)
        }
    }
}
