//
//  UserManager.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//
import Foundation

final class UserManager: ObservableObject {
    static let shared = UserManager()
    @Published var user: User? = LocalDatabase.loadUser()
    @Published var companySettingsAuthKey: String = LocalDatabase.loadAuthKey() ?? "060fac9a80afec9b95eb292ad884c5f5"

    private init() {}

    func updateAuthKey(_ key: String) {
        companySettingsAuthKey = key
        LocalDatabase.saveAuthKey(key)
    }
}
