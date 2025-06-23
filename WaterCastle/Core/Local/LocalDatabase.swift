//
//  LocalDatabase.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//

import Foundation

struct LocalDatabase {
    static let companySettingsKey = "companySettings"

    static func saveCompanySettings(_ settings: CompanySettingsResponse.Rows) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: companySettingsKey)
        }
    }

    static func loadCompanySettings() -> CompanySettingsResponse.Rows? {
        if let data = UserDefaults.standard.data(forKey: companySettingsKey),
           let settings = try? JSONDecoder().decode(CompanySettingsResponse.Rows.self, from: data) {
            return settings
        }
        return nil
    }
}
