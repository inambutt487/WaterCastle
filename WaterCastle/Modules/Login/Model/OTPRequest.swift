import Foundation

struct OTPRequest: Encodable {
    let mobile: String
    let otp: String
}