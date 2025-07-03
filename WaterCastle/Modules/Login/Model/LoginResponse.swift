// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation

// MARK: - LoginResponse
struct LoginResponse : Codable{
    let code: Int?
    let userType, messageEn, messageAr, messageKw: String?
    let result, signup: String?
}
