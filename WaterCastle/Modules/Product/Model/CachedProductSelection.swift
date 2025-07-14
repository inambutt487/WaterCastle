//
//  CachedProductSelection.swift
//  WaterCastle
//
//  Created by Mac on 07/07/2025.
//


struct CachedProductSelection: Codable {
    let product: ProductData
    let promotions: [Promotion]
    let quantity: Int
}