//
//  CompanySettingsManager.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//
import Foundation

final class CompanySettingsManager: ObservableObject {
    static let shared = CompanySettingsManager()
    @Published var settings: Rows?

    private init() {
        self.settings = LocalDatabase.loadCompanySettings()
    }
}
