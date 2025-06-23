//
//  WaterCastleApp.swift
//  WaterCastle
//
//  Created by Mac on 23/06/2025.
//

import SwiftUI

@main
struct WaterCastleApp: App {
    @State private var showSplash = true

        var body: some Scene {
            WindowGroup {
                if showSplash {
                    SplashScreenView(isActive: $showSplash)
                } else {
                    StartView()
                }
            }
        }
}
