//
//  AddToCartRequest.swift
//  WaterCastle
//
//  Created by Mac on 30/06/2025.
//


import Foundation

// MARK: - AddToCartRequest
struct AddToCartRequest: Encodable {
    let add_type: String
    let area_id: String
    let address_id: String
    let client_id: String
    let country_id: String
    let cart: [CartItem]
    let fcmToken: String
}

struct CartItem: Encodable {
    let product_price: String
    let count: String
    let dish_id: String
    let haspromocode: Bool
    let Price: String
    let productTitleEN: String
}
