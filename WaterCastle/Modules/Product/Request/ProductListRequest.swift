import Foundation

struct ProductListRequest: Encodable {
    let add_type: String
    let area_id: String
    let country_id: String
    let customer_id: String
    let fcm_token: String
} 
