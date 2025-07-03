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
    private init() {}
}
