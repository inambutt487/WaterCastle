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

    // MARK: - Address List
    static let addressesKey = "userAddresses"
    static let homeAddressKey = "homeAddress"
    static func saveAddresses(_ addresses: [Address]) {
        if let data = try? JSONEncoder().encode(addresses) {
            UserDefaults.standard.set(data, forKey: addressesKey)
            // Save the first address as the home address by default
            if let first = addresses.first {
                saveHomeAddress(first)
            }
        }
    }
    static func loadAddresses() -> [Address]? {
        if let data = UserDefaults.standard.data(forKey: addressesKey) {
            return try? JSONDecoder().decode([Address].self, from: data)
        }
        return nil
    }
    static func saveHomeAddress(_ address: Address) {
        if let data = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(data, forKey: homeAddressKey)
        }
    }
    static func loadHomeAddress() -> Address? {
        if let data = UserDefaults.standard.data(forKey: homeAddressKey) {
            return try? JSONDecoder().decode(Address.self, from: data)
        }
        return nil
    }
}

extension LocalDatabase {
    static let cachedProductSelectionKey = "cachedProductSelection"
    static func saveProductSelection(_ selection: CachedProductSelection) {
        if let data = try? JSONEncoder().encode(selection) {
            UserDefaults.standard.set(data, forKey: cachedProductSelectionKey)
        }
    }
    static func loadProductSelection() -> CachedProductSelection? {
        if let data = UserDefaults.standard.data(forKey: cachedProductSelectionKey) {
            return try? JSONDecoder().decode(CachedProductSelection.self, from: data)
        }
        return nil
    }
    static func clearProductSelection() {
        UserDefaults.standard.removeObject(forKey: cachedProductSelectionKey)
    }
}
