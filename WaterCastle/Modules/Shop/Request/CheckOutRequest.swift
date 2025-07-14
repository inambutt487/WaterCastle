import Foundation


struct CheckOutRequest: Encodable {
    let area_id: String
    let address_id: String
    let client_id: String
    let country_id: String
    let cart: [ShopCartItem]
    let fcmToken: String
    // Add any additional fields required by the checkout API
}

// Shop module
struct ShopCartItem: Encodable {
    let product_price: String?
    let count: String
    let dish_id: String?
    let haspromocode: Bool?
    let Price: String?
    let productTitleEN: String?
}
