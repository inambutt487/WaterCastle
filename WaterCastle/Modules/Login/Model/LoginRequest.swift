//
//  LoginRequest.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//


import Foundation

struct LoginRequest: Encodable {
    let mobile: String
    let language: String
    let sk_key: String
    let country_id: Int
}