//
//  LocalDatabase.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//

import Foundation

struct LocalDatabase {
    static let companySettingsKey = "companySettings"

    static func saveCompanySettings(_ settings: Rows) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: companySettingsKey)
        }
    }

    static func loadCompanySettings() -> Rows? {
        if let data = UserDefaults.standard.data(forKey: companySettingsKey) {
            do {
                let settings = try JSONDecoder().decode(Rows.self, from: data)
                return settings
            } catch {
                print("[LocalDatabase] Failed to decode CompanySettingsResponse.Rows: \(error)")
            }
        }
        return nil
    }
}
