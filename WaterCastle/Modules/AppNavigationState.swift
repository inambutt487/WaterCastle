//
//  AppNavigationState.swift
//  WaterCastle
//
//  Created by Mac on 11/07/2025.
//
import Foundation

class AppNavigationState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var showProductDetails: Bool = false
    @Published var selectedProduct: ProductData? = nil
    @Published var selectedPromotions: [Promotion] = []
    @Published var selectedQuantity: Int = 1

    func resetToLogin() {
        isLoggedIn = false
        showProductDetails = false
        selectedProduct = nil
        selectedPromotions = []
        selectedQuantity = 1
    }
}
