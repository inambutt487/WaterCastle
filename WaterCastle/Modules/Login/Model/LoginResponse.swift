import Foundation

struct LoginResponse: Decodable {
    let code: Int?
    let userType: String?
    let messageEn: String?
    let result: String?
    let signup: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case userType = "user_type"
        case messageEn = "message_en"
        case result, signup
    }
}