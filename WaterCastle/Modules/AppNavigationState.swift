//
//  AppNavigationState.swift
//  WaterCastle
//
//  Created by Mac on 11/07/2025.
//
import Foundation

class AppNavigationState: ObservableObject {
    // Splash/Intro navigation state
    @Published var showSplash: Bool = true
    @Published var showIntro: Bool = false

    // Track if user has seen intro and start view
    @Published var hasSeenIntro: Bool = UserDefaults.standard.bool(forKey: "hasSeenIntro") {
        didSet {
            UserDefaults.standard.set(hasSeenIntro, forKey: "hasSeenIntro")
        }
    }
    @Published var hasSeenStartView: Bool = UserDefaults.standard.bool(forKey: "hasSeenStartView") {
        didSet {
            UserDefaults.standard.set(hasSeenStartView, forKey: "hasSeenStartView")
        }
    }

    @Published var isLoggedIn: Bool = false
    @Published var showProductDetails: Bool = false
    @Published var selectedProduct: ProductData? = nil
    @Published var selectedPromotions: [Promotion] = []
    @Published var selectedQuantity: Int = 1

    func markIntroSeen() {
        hasSeenIntro = true
    }
    func markStartViewSeen() {
        hasSeenStartView = true
    }

    func resetToLogin() {
        isLoggedIn = false
        showProductDetails = false
        selectedProduct = nil
        selectedPromotions = []
        selectedQuantity = 1
    }
}
