//
//  CheckOutResponse.swift
//  WaterCastle
//
//  Created by Mac on 08/07/2025.
//

import Foundation

struct CheckOutResponse: Codable {
    let code: Int?
    let isValidOrder: Int?
    let deliverySlots: [Delivery_slots]?
    let showReferral: String?
    let clientWalletBalance: Int?
    let paymentMethods: [Payment_methods]?
    let creditLimit: Int?
    let walletDiscount: Int?
    let deliveryCharges: String?
    let companies: [Companies]?
    let rangeWallet: [Range_wallet]?
    let loyaltyPoints: String?
    let loyaltyPointsMessageEn: String?
    let loyaltyPointsMessageAr: String?
    let redeemPointFactor: String?
    let loyaltyWallet: String?
    let newDeliverySlots: [New_delivery_slots]?
    let showDeliveryDay: Int?
    let selectedTimeSlot: Int?
    let showDeliveryAsap: Int?
    let showDeliveryAsapTextEn: String?
    let showDeliveryAsapTextAr: String?
    let showDeliveryAsapTextKw: String?
    let addNewAddress: Int?
    let tamaraURL: String?
    let tamaraAuthToken: String?
    let tamaraPublicKey: String?
    let tamaraMinQty: String?
    let tamaraDelvieryFee: [Tamara_delviery_fee]?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case isValidOrder = "is_valid_order"
        case deliverySlots = "delivery_slots"
        case showReferral = "show_referral"
        case clientWalletBalance = "client_wallet_balance"
        case paymentMethods = "payment_methods"
        case creditLimit = "credit_limit"
        case walletDiscount = "wallet_discount"
        case deliveryCharges = "delivery_charges"
        case companies
        case rangeWallet = "range_wallet"
        case loyaltyPoints = "loyalty_points"
        case loyaltyPointsMessageEn = "loyalty_points_message_en"
        case loyaltyPointsMessageAr = "loyalty_points_message_ar"
        case redeemPointFactor = "redeem_point_factor"
        case loyaltyWallet = "loyalty_wallet"
        case newDeliverySlots = "new_delivery_slots"
        case showDeliveryDay = "show_delivery_day"
        case selectedTimeSlot = "selected_time_slot"
        case showDeliveryAsap = "show_delivery_asap"
        case showDeliveryAsapTextEn = "show_delivery_asap_text_en"
        case showDeliveryAsapTextAr = "show_delivery_asap_text_ar"
        case showDeliveryAsapTextKw = "show_delivery_asap_text_kw"
        case addNewAddress = "add_new_address"
        case tamaraURL = "tamara_url"
        case tamaraAuthToken = "tamara_auth_token"
        case tamaraPublicKey = "tamara_public_key"
        case tamaraMinQty = "tamara_min_qty"
        case tamaraDelvieryFee = "tamara_delviery_fee"
    }
}

struct Companies : Codable {
    let id : Int?
    let name : String?
    let logo : String?
    let method : String?
    let account_id : String?
    let meta : Meta?
    let type : String?
    let sort : Int?
    let show_on_cart : Int?
    let max_amount : String?
    let country_id : Int?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let name_en : String?
    let name_ar : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case logo = "logo"
        case method = "method"
        case account_id = "account_id"
        case meta = "meta"
        case type = "type"
        case sort = "sort"
        case show_on_cart = "show_on_cart"
        case max_amount = "max_amount"
        case country_id = "country_id"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case name_en = "name_en"
        case name_ar = "name_ar"
    }

}

struct Delivery_slots : Codable {
    let id : String?
    let title_en : String?
    let title_ar : String?
    let title_kw : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title_en = "title_en"
        case title_ar = "title_ar"
        case title_kw = "title_kw"
        case status = "status"
    }

}

struct Meta : Codable {
    let key : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
    }

}

struct New_delivery_slots : Codable {
    let days : String?
    let time : [TimeElement]?

    enum CodingKeys: String, CodingKey {

        case days = "days"
        case time = "time"
    }

}


struct Payment_methods : Codable {
    let id : String?
    let title_en : String?
    let title_ar : String?
    let title_kw : String?
    let status : String?
    let pay_later : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title_en = "title_en"
        case title_ar = "title_ar"
        case title_kw = "title_kw"
        case status = "status"
        case pay_later = "pay_later"
    }

}

struct Range_wallet : Codable {
    let min_qty : String?
    let max_qty : String?
    let wallet : String?

    enum CodingKeys: String, CodingKey {

        case min_qty = "min_qty"
        case max_qty = "max_qty"
        case wallet = "wallet"
    }

}


struct Tamara_delviery_fee : Codable {
    let min : String?
    let max : String?
    let delivery_fee : String?

    enum CodingKeys: String, CodingKey {

        case min = "min"
        case max = "max"
        case delivery_fee = "delivery_fee"
    }

}


struct TimeElement : Codable {
    let id : Int?
    let time : TimeValue?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case time = "time"
    }
}

struct TimeValue: Codable {
    let en: String?
    let ar: String?

    enum CodingKeys: String, CodingKey {
        case en = "en"
        case ar = "ar"
    }
}

