//
//  CompanySettingsResponse.swift
//  shopcastle
//
//  Created by Mac on 18/06/2025.
//
struct CompanySettingsResponse: Codable {
    let Code: Int
    let rows: Rows

    struct Rows: Codable {
        let min_order: String
        let min_qty: String
        let vat: String
        // Add other fields as needed
    }
}
