// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: jsonData)

import Foundation
struct LoginResponse : Codable {
    let code : Int?
    let user_type : String?
    let message_en : String?
    let message_ar : String?
    let message_kw : String?
    let result : String?
    let signup : String?

    enum CodingKeys: String, CodingKey {

        case code = "Code"
        case user_type = "user_type"
        case message_en = "message_en"
        case message_ar = "message_ar"
        case message_kw = "message_kw"
        case result = "result"
        case signup = "signup"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        message_en = try values.decodeIfPresent(String.self, forKey: .message_en)
        message_ar = try values.decodeIfPresent(String.self, forKey: .message_ar)
        message_kw = try values.decodeIfPresent(String.self, forKey: .message_kw)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        signup = try values.decodeIfPresent(String.self, forKey: .signup)
    }

}
