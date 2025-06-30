import Foundation

// MARK: - AddToCartRequest
struct AddToCartRequest {
    let addType, areaID, addressID, clientID: String?
    let countryID: String?
    let cart: [Cart]?
    let fcmToken: String?
}

// MARK: - Cart
struct Cart {
    let productPrice, count, dishID: String?
    let haspromocode: Bool?
    let price, productTitleEN: String?
}