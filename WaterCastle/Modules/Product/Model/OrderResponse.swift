//
//  OrderResponse.swift
//  WaterCastle
//
//  Created by Mac on 30/06/2025.
//


import Foundation

// MARK: - OrderResponse
struct OrderResponse: Codable {
    let code, isValidOrder: Int?
    let duplicateOrders: String?
    let latestOrders: [String]?
    let showReferral, showStcTamayouz, stcTamayouzMinQty, defaultPromo: String?
    let promoObject: PromoObject?
    let deliveryCharges, saffMsgEn, saffMsgAr: String?
    let remainingQtySaff: Int?
    let isSaffMember: Bool?
    let checkoutMsgEn, checkoutMsgAr: String?
    let showPromoField: Int?
    let loyaltyFocItems, loyaltyGiftItems: [String]?
    let rewardPrograms: [RewardProgram]?
    let promotionMessage: PromotionMessage?
    let generalMessage: GeneralMessage?
    let newDeliveryFee: [NewDeliveryFee]?
    let similarProducts: [Int]?
    let isCompanyUser: Int?
    let tamaraURL: String?
    let tamaraAuthToken, tamaraPublicKey, companyMessageEn, companyMessageAr: String?
    let promoImageEn, promoImageAr, stcTamayouzImageEn, stcTamayouzImageAr: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case isValidOrder = "is_valid_order"
        case duplicateOrders = "duplicate_orders"
        case latestOrders = "latest_orders"
        case showReferral = "show_referral"
        case showStcTamayouz = "show_stc_tamayouz"
        case stcTamayouzMinQty = "stc_tamayouz_min_qty"
        case defaultPromo = "default_promo"
        case promoObject = "promo_object"
        case deliveryCharges = "delivery_charges"
        case saffMsgEn = "saff_msg_en"
        case saffMsgAr = "saff_msg_ar"
        case remainingQtySaff = "remaining_qty_saff"
        case isSaffMember = "is_saff_member"
        case checkoutMsgEn = "checkout_msg_en"
        case checkoutMsgAr = "checkout_msg_ar"
        case showPromoField = "show_promo_field"
        case loyaltyFocItems = "loyalty_foc_items"
        case loyaltyGiftItems = "loyalty_gift_items"
        case rewardPrograms = "reward_programs"
        case promotionMessage = "promotion_message"
        case generalMessage = "general_message"
        case newDeliveryFee = "new_delivery_fee"
        case similarProducts = "similar_products"
        case isCompanyUser = "is_company_user"
        case tamaraURL = "tamara_url"
        case tamaraAuthToken = "tamara_auth_token"
        case tamaraPublicKey = "tamara_public_key"
        case companyMessageEn = "company_message_en"
        case companyMessageAr = "company_message_ar"
        case promoImageEn = "promo_image_en"
        case promoImageAr = "promo_image_ar"
        case stcTamayouzImageEn = "stc_tamayouz_image_en"
        case stcTamayouzImageAr = "stc_tamayouz_image_ar"
    }
}

// MARK: - GeneralMessage
struct GeneralMessage: Codable {
    let titleEn, titleAr, messageEn, messageAr: String?
    let minQty, maxQty: Int?
    let iconEn, iconAr: String?

    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
        case minQty = "min_qty"
        case maxQty = "max_qty"
        case iconEn = "icon_en"
        case iconAr = "icon_ar"
    }
}

// MARK: - NewDeliveryFee
struct NewDeliveryFee: Codable {
    let min, max: Int?
    let deliveryFee: String?

    enum CodingKeys: String, CodingKey {
        case min, max
        case deliveryFee = "delivery_fee"
    }
}

// MARK: - PromoObject
struct PromoObject: Codable {
}

// MARK: - PromotionMessage
struct PromotionMessage: Codable {
    let titleEn, titleAr, messageEn, messageAr: String
    let minQty, maxQty, iconEn, iconAr: String

    enum CodingKeys: String, CodingKey {
        case titleEn = "title_en"
        case titleAr = "title_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
        case minQty = "min_qty"
        case maxQty = "max_qty"
        case iconEn = "icon_en"
        case iconAr = "icon_ar"
    }
}

// MARK: - RewardProgram
struct RewardProgram: Codable {
    let id: Int?
    let name: Message?
    let factor: Double?
    let offerPoints, offerAmount: Int?
    let message: Message?
    let image, imageEn, imageAr, messageEn: String?
    let messageAr: String?

    enum CodingKeys: String, CodingKey {
        case id, name, factor
        case offerPoints = "offer_points"
        case offerAmount = "offer_amount"
        case message, image
        case imageEn = "image_en"
        case imageAr = "image_ar"
        case messageEn = "message_en"
        case messageAr = "message_ar"
    }
}

// MARK: - Message
struct Message: Codable {
    let en, ar: String?
}
