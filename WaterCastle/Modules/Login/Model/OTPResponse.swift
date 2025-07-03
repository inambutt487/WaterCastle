//
//  OTPResponse.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let oTPResponse = try? JSONDecoder().decode(OTPResponse.self, from: jsonData)

import Foundation

// MARK: - OTPResponse
struct OTPResponse : Codable, Equatable{
    let code: Int?
    let userType, message, result, welcomeMessageEn: String?
    let welcomeMessageAr: String?
    let status: Bool?
    let specialPromotion, showRegistrationForm: Int?
    let user: [User]?
    let address: [Address]?
    let getToken: GetToken?
}

// MARK: - Address
struct Address: Codable, Equatable {
    let addID: String?
    let sapID: SapID?
    let userID, addArea: Int?
    let addName, addDetail, addStreetName, addLatitude: String?
    let addLongitude, addBuilding: String?
    let addBlock, addFloor: Int?
    let addGoogleAddress, addCity: String?
    let addType: Int?
    let addCountry, routeID, lable: String?
}

enum SapID: String, Codable, Equatable {
    case empty = ""
    case the7002458623 = "7002458623"
}

// MARK: - GetToken
struct GetToken: Codable, Equatable {
    let code: Int?
    let auth, status: String?
}

// MARK: - User
struct User: Codable, Equatable {
    let userID, accountTypeID, channelID, subChannelID: String?
    let groupID, creditLimit, hidePrice, addAddress: String?
    let email, pass, fristName, firstName: String?
    let lastName, mobile: String?
    let emailActive: Int?
    let phone, identityNum, authKey: String?
    let status, forceChangePassword, showRegistrationForm, marketingSMSAllowed: Int?
    let allowEmailNotification, allowPromotionNotification: Int?
    let isPayer: Bool?
}
