//
//  LocalDatabase.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//

import Foundation

struct LocalDatabase {
    static let companySettingsKey = "companySettings"

    static func saveCompanySettings(_ settings: CompanySettingData) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: companySettingsKey)
        }
    }

    static func loadCompanySettings() -> CompanySettingData? {
        if let data = UserDefaults.standard.data(forKey: companySettingsKey) {
            do {
                let settings = try JSONDecoder().decode(CompanySettingData.self, from: data)
                return settings
            } catch {
                print("[LocalDatabase] Failed to decode CompanySettingsResponse.Rows: \(error)")
            }
        }
        return nil
    }
    
    static let userKey = "loggedInUser"

    static func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    static func loadUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: userKey) {
            return try? JSONDecoder().decode(User.self, from: data)
        }
        return nil
    }

    // MARK: - Auth Key
    static let authKey = "companySettingsAuthKey"
    static func saveAuthKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: authKey)
    }
    static func loadAuthKey() -> String? {
        UserDefaults.standard.string(forKey: authKey)
    }

    // MARK: - ProductData Cache
    static let productCacheKey = "cachedProducts"
    static func saveProducts(_ products: [ProductData]) {
        if let data = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(data, forKey: productCacheKey)
        }
    }
    static func loadProducts() -> [ProductData]? {
        if let data = UserDefaults.standard.data(forKey: productCacheKey) {
            return try? JSONDecoder().decode([ProductData].self, from: data)
        }
        return nil
    }

    // MARK: - Promotion Cache
    static let promotionCacheKey = "cachedPromotions"
    static func savePromotions(_ promotions: [Promotion]) {
        if let data = try? JSONEncoder().encode(promotions) {
            UserDefaults.standard.set(data, forKey: promotionCacheKey)
        }
    }
    static func loadPromotions() -> [Promotion]? {
        if let data = UserDefaults.standard.data(forKey: promotionCacheKey) {
            return try? JSONDecoder().decode([Promotion].self, from: data)
        }
        return nil;
    }
}
