//
//  OTPRequest.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//


import Foundation

struct OTPRequest: Encodable {
    let mobile: String
    let otp: String
}