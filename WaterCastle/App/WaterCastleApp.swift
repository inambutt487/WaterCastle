//
//  WaterCastleApp.swift
//  WaterCastle
//
//  Created by Mac on 23/06/2025.
//

import SwiftUI

@main
struct WaterCastleApp: App {
    @StateObject var nav = AppNavigationState()

    init() {
        URLProtocol.registerClass(NetworkLoggerProtocol.self)
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if nav.showSplash {
                    SplashScreenView()
                        .environmentObject(nav)
                } else if !nav.hasSeenIntro {
                    IntroSlidesView(
                        viewModel: IntroSlidesViewModel(),
                        isFinished: Binding(get: { nav.hasSeenIntro }, set: { nav.hasSeenIntro = $0 }),
                        onFinish: { nav.markIntroSeen() }
                    )
                    .environmentObject(nav)
                } else if !nav.hasSeenStartView {
                    StartView()
                        .environmentObject(nav)
                } else {
                    MainController()
                        .environmentObject(nav)
                }
            }
        }
    }
}
