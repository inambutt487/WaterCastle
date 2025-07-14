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

struct OTPResponse : Codable, Equatable {
    let code : Int
    let user_type : String?
    let message : String?
    let result : String?
    let welcome_message_en : String?
    let welcome_message_ar : String?
    let status : Bool?
    let special_promotion : Int?
    let show_registration_form : Int?
    let user : [User]?
    let address : [Address]?
    let getToken : GetToken?

    enum CodingKeys: String, CodingKey {

        case code = "Code"
        case user_type = "user_type"
        case message = "Message"
        case result = "result"
        case welcome_message_en = "welcome_message_en"
        case welcome_message_ar = "welcome_message_ar"
        case status = "status"
        case special_promotion = "special_promotion"
        case show_registration_form = "show_registration_form"
        case user = "user"
        case address = "address"
        case getToken = "getToken"
    }
}

struct User : Codable, Equatable {
    let user_id : String?
    let account_type_id : String?
    let channel_id : String?
    let sub_channel_id : String?
    let group_id : String?
    let credit_limit : String?
    let hide_price : String?
    let add_address : String?
    let email : String?
    let pass : String?
    let frist_name : String?
    let first_name : String?
    let last_name : String?
    let mobile : String?
    let email_active : Int?
    let phone : String?
    let identity_num : String?
    let auth_key : String?
    let status : Int?
    let force_change_password : Int?
    let show_registration_form : Int?
    let marketing_sms_allowed : Int?
    let allow_email_notification : Int?
    let allow_promotion_notification : Int?
    let is_payer : Bool?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case account_type_id = "account_type_id"
        case channel_id = "channel_id"
        case sub_channel_id = "sub_channel_id"
        case group_id = "group_id"
        case credit_limit = "credit_limit"
        case hide_price = "hide_price"
        case add_address = "add_address"
        case email = "email"
        case pass = "pass"
        case frist_name = "frist_name"
        case first_name = "first_name"
        case last_name = "last_name"
        case mobile = "mobile"
        case email_active = "email_active"
        case phone = "phone"
        case identity_num = "identity_num"
        case auth_key = "auth_key"
        case status = "status"
        case force_change_password = "force_change_password"
        case show_registration_form = "show_registration_form"
        case marketing_sms_allowed = "marketing_sms_allowed"
        case allow_email_notification = "allow_email_notification"
        case allow_promotion_notification = "allow_promotion_notification"
        case is_payer = "is_payer"
    }
}

struct Address : Codable, Equatable {
    let add_id : String?
    let sap_id : String?
    let user_id : Int?
    let add_area : Int?
    let add_name : String?
    let add_detail : String?
    let add_street_name : String?
    let add_latitude : String?
    let add_longitude : String?
    let add_building : String?
    let add_block : Int?
    let add_floor : Int?
    let add_google_address : String?
    let add_city : String?
    let add_type : Int?
    let add_country : String?
    let route_id : String?
    let lable : String?

    enum CodingKeys: String, CodingKey {

        case add_id = "add_id"
        case sap_id = "sap_id"
        case user_id = "user_id"
        case add_area = "add_area"
        case add_name = "add_name"
        case add_detail = "add_detail"
        case add_street_name = "add_street_name"
        case add_latitude = "add_latitude"
        case add_longitude = "add_longitude"
        case add_building = "add_building"
        case add_block = "add_block"
        case add_floor = "add_floor"
        case add_google_address = "add_google_address"
        case add_city = "add_city"
        case add_type = "add_type"
        case add_country = "add_country"
        case route_id = "route_id"
        case lable = "lable"
    }
}

struct GetToken : Codable, Equatable {
    let code : Int?
    let auth : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case code = "Code"
        case auth = "auth"
        case status = "status"
    }
}
