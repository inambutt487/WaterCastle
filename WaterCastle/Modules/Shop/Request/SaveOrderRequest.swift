import Foundation

struct SaveOrderRequest: Encodable {
    let addressData: Address
    let amount: String
    let amount_vat: String
    let cart: [SaveOrderCartItem]
    let checkout_time: String
    let prefered_date: String
    let prefered_time: String
    let payment_id: String
    let payment_type: String
    let company_id: Int?
    // Add other fields as needed, matching the API
    // e.g. foc_items, loyalty_foc_items, loyalty_gift_items, etc.
}

struct SaveOrderCartItem: Encodable {
    let count: Int
    let dish_id: String
    let price: String
    let productTitleEn: String
    let product_price: String
    // Add other fields as needed
} 