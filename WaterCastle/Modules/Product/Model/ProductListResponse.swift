//
//  ProductListResponse.swift
//  WaterCastle
//
//  Created by Mac on 25/06/2025.
//


struct ProductListResponse: Codable {
    let status: Bool?
    let message: String?
    let rows: [ProductData]?
}
