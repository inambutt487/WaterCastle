import Foundation

struct OTPResponse: Decodable {
    let code: Int?
    let userType: String?
    let message: String?
    let result: String?
    let user: [User]?
    // ... add other fields as needed
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case userType = "user_type"
        case message = "Message"
        case result, user
    }
}

struct User: Codable {
    let userId: String?
    let authKey: String?
    // ... add other fields as needed
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case authKey = "auth_key"
    }
}