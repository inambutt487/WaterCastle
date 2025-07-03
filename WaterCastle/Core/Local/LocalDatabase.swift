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
}
